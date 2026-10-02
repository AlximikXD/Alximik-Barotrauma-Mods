-- Autorun bootstrap – гарантує запуск ForcedAutorun/init.lua
print("[UA DEBUG] boot.lua loaded (Autorun)")

if SERVER then
  print("[UA DEBUG] Running on SERVER -> skip client scripts.")
  return
end

local ok, err = pcall(function()
  require("ForcedAutorun/init")    -- шукає %ModDir%/Lua/ForcedAutorun/init.lua
end)

if ok then
  print("[UA DEBUG] ForcedAutorun/init.lua required successfully.")
else
  print("[UA ERROR] Failed to require ForcedAutorun/init.lua: "..tostring(err))
  print("[UA ERROR] Check file path: %ModDir%/Lua/ForcedAutorun/init.lua")
end