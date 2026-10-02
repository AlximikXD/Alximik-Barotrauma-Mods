-----------------------------------------------------------------------
-- UA Localization Filter – ForcedAutorun/init.lua (client-side)
-- Вимикає переклади модів, які НЕ увімкнені.
-- Повний дебаг + автозапуск (Timer.Wait + mod.init) + ua_refilter + ua_resync.
-----------------------------------------------------------------------

print("[UA DEBUG] init.lua (ForcedAutorun) loaded")

-- лише клієнт
if SERVER then
  print("[UA DEBUG] Detected SERVER environment -> aborting (client only).")
  return
end

-- ===== НАЗВА ВАШОГО ПАКЕТА (точно як у списку модів) =====
local UA_PACKAGE_NAME = "Українська Локалізація   Ukrainian Localization"

-- ===== STAGE 1: require конфіг (WorkshopID/Name -> files) =====
local ok_cfg, MAP_or_err = pcall(function()
  return require("config/ua_texts")   -- %ModDir%/Lua/config/ua_texts.lua
end)

if not ok_cfg then
  print("[UA ERROR] Failed to require config/ua_texts.lua:")
  print("[UA ERROR] "..tostring(MAP_or_err))
  return
end

if type(MAP_or_err) ~= "table" then
  print("[UA ERROR] config/ua_texts.lua must return a table, got: "..type(MAP_or_err))
  return
end

local MAP = MAP_or_err
do
  local c=0; for _ in pairs(MAP) do c=c+1 end
  print("[UA DEBUG] config/ua_texts.lua loaded. Entries: "..tostring(c))
end

-- ===== helpers =====
local function nrm(p) return tostring(p or ""):lower():gsub("\\","/") end

local function listEnabledPackages()
  print("[UA DEBUG] ===== Enabled content packages =====")
  local i=0
  for pkg in ContentPackageManager.EnabledPackages.All do
    i=i+1
    print(string.format("[UA DEBUG]  #%d  %s  (ID: %s)", i, pkg.Name, tostring(pkg.UgcId)))
  end
  print(string.format("[UA DEBUG] Total enabled packages: %d", i))
  print("[UA DEBUG] ====================================")
end

local function isModEnabledByIdOrName(targetId, targetName)
  targetId      = targetId and tostring(targetId) or ""
  local tname   = targetName or ""
  local tname_l = tname:lower()

  for pkg in ContentPackageManager.EnabledPackages.All do
    local id = tostring(pkg.UgcId or "")
    if id == targetId and id ~= "0" then
      return true, pkg, "id"
    end
    if tname ~= "" and pkg.Name == tname then
      return true, pkg, "name"
    end
    if tname ~= "" and pkg.Name:lower() == tname_l then
      return true, pkg, "name-ci"
    end
  end
  return false, nil, "none"
end

local function unloadOne(relPath, modId, modName)
  local needle = nrm(relPath)
  for pkg in ContentPackageManager.EnabledPackages.All do
    for file in pkg.Files do
      if LuaUserData.IsTargetType(file, "Barotrauma.TextFile") then
        local path = nrm(file.Path.Value)
        if path:sub(-#needle) == needle then
          local ok, err = pcall(function() file.UnloadFile() end)
          if ok then
            print(string.format("[UA DEBUG] UNLOADED: %s (mod %s%s)",
              file.Path.Value, tostring(modId or "?"), modName and (" / "..modName) or ""))
          else
            print(string.format("[UA ERROR] UnloadFile failed: %s", tostring(err)))
          end
          return true
        end
      end
    end
  end
  print(string.format("[UA DEBUG]   not found among loaded text files -> %s", relPath))
  return false
end

local function disableForEntry(modId, entry)
  local modName = (type(entry) == "table") and entry.name or nil
  local files   = (type(entry) == "table") and entry.files or entry
  if type(files) == "table" then
    for _, p in ipairs(files) do unloadOne(p, modId, modName) end
  elseif type(files) == "string" then
    unloadOne(files, modId, modName)
  end
end

local function applyFilter()
  print("[UA DEBUG] --- applyFilter(): start ---")
  for modId, entry in pairs(MAP) do
    local modName = (type(entry) == "table") and entry.name or nil
    local ok = isModEnabledByIdOrName(modId, modName)
    if not ok then
      disableForEntry(modId, entry)
    else
      print(string.format("[UA DEBUG] Keeping translations for mod %s%s",
        tostring(modId), modName and (" / "..modName) or ""))
    end
  end
  print("[UA DEBUG] --- applyFilter(): done ---")
end

local function runPipeline()
  print("[UA DEBUG] ===== UA pipeline start =====")
  listEnabledPackages()
  applyFilter()
  print("[UA DEBUG] ===== UA pipeline end =====")
  print("[UA NOTICE] Якщо ви щойно увімкнули/вимкнули моди, перезапустіть гру або використайте: ua_resync")
end

-- ===== extra helpers for ua_resync =====
local function getCurrentLanguageName()
  local ok, lang = pcall(function() return tostring(TextManager and TextManager.Language or "") end)
  if ok and lang ~= "" then return lang end
  return "English"
end

local function trySetLanguage(lang)
  local reapplied = false
  pcall(function()
    if TextManager and TextManager.SetLanguage then
      TextManager.SetLanguage(lang)
      reapplied = true
    end
  end)
  if not reapplied then
    pcall(function()
      if GameSettings and GameSettings.SetLanguage then
        GameSettings.SetLanguage(lang)
        reapplied = true
      end
    end)
  end
  if reapplied then
    print("[UA DEBUG] Language reapplied: "..tostring(lang))
  else
    print("[UA WARN] Couldn't reapply language automatically. Set '"..tostring(lang).."' in Settings > Language.")
  end
end

local function isSessionActive()
  -- allow resync only when a session/screen is running (campaign/mp/editor)
  local active = false
  pcall(function() if Game and Game.GameSession then active = true end end)
  if not active then pcall(function() if Game and Game.IsMultiplayer then active = true end end) end
  return active
end

-- ===== автозапуск =====
local didRun = false
local function safeRunPipeline(origin)
  if didRun then return end
  didRun = true
  print("[UA DEBUG] Starting pipeline, origin="..tostring(origin))
  runPipeline()
end

Timer.Wait(function() safeRunPipeline("Timer.Wait(250ms)") end, 250)
Hook.Add("mod.init", "UA_DisableUnusedTexts", function()
  safeRunPipeline("mod.init")
end)

-- ===== консольні команди =====
Game.AddCommand("ua_listpkgs", "List enabled packages with their UgcId.", function()
  listEnabledPackages()
end, GetValidArguments)

Game.AddCommand("ua_refilter", "Re-apply UA text filtering now.", function()
  didRun = false
  safeRunPipeline("ua_refilter")
end, GetValidArguments)

-- ua_resync: reload UA package and filter again (session-only) + restore language
local function getPackageByName(name)
  for pkg in ContentPackageManager.EnabledPackages.All do
    if pkg.Name == name then return pkg end
  end
end

Game.AddCommand("ua_resync", "Reload UA package and re-apply filter.", function()
  print("[UA DEBUG] Command ua_resync called.")

  if not isSessionActive() then
    print("[UA NOTICE] ua_resync works after starting a session (Campaign/MP/Sub Editor).")
    print("[UA NOTICE] Tip: use ua_refilter in the main menu, or start a session then run ua_resync.")
    return
  end

  local prevLang = getCurrentLanguageName()
  print("[UA DEBUG] Current language before reload: "..tostring(prevLang))

  local ua = getPackageByName(UA_PACKAGE_NAME)
  if not ua then
    print("[UA ERROR] UA package not found: "..UA_PACKAGE_NAME)
    print("[UA ERROR] If the visible name differs, update UA_PACKAGE_NAME near the top of init.lua.")
    return
  end

  ContentPackageManager.EnabledPackages.EnableRegular(ua)
  local res = ContentPackageManager.ReloadContentPackage(ua)
  if res.IsFailure then
    print("[UA ERROR] Reload failed: "..tostring(res.Error))
    return
  end

  print("[UA DEBUG] UA package reloaded. Re-applying filter…")
  didRun = false
  safeRunPipeline("ua_resync")

  -- Restore language shortly after reload so it doesn't stick to English
  Timer.Wait(function()
    trySetLanguage(prevLang)
  end, 150)

  print("[UA NOTICE] Resync complete. If some mods still show English text, do a full game restart.")
end, GetValidArguments)

-----------------------------------------------------------------------
-- End of file
-----------------------------------------------------------------------
