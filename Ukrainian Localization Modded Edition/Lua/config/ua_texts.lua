-- WorkshopID -> { name = "<Package Name>", files = string | {strings} }
-- If a mod is local (UgcId = 0), the code will fall back to matching by 'name'.
-- Replace "WORKSHOP_ID_HERE" with real IDs as you learn them.
return {
  -- Single-file helper (not sure of its exact workshop name)
  ["2814493175"] = {
    name  = "More Level Content",
    files = "Mods/MoreLevelContent.xml"
  },

  -- Dynamic Europa (many files)
  ["2532991202"] = {
    name  = "Dynamic Europa",
    files = {
      "Mods/DynamicEuropa/Missions.xml",
      "Mods/DynamicEuropa/Structures.xml",
      "Mods/DynamicEuropa/Talents.xml",
      "Mods/DynamicEuropa/Locations.xml",
      "Mods/DynamicEuropa/Items.xml",
      "Mods/DynamicEuropa/Factions.xml",
      "Mods/DynamicEuropa/Dialog.xml",
      "Mods/DynamicEuropa/Characters.xml",
      "Mods/DynamicEuropa/Afflictions.xml",
      "Mods/DynamicEuropa/Overrides.xml",
      "Mods/DynamicEuropa/HungryEuropansFiles.xml",
      "Mods/DynamicEuropa/SpeacialCharactersEventText.xml"
    }
  },

  -- Neurotrauma
  ["3190189044"] = {
    name  = "Neurotrauma",
    files = "Mods/Neurotrauma/Neurotrauma.xml"
  },

  -- NT addons
  ["3324062208"] = {
    name  = "NT Cybernetics Enchanced",
    files = "Mods/NTCyberneticsEnchanced/Ukrainian.xml"
  },
  ["3478666406"] = {
    name  = "NT Symbiote",
    files = "Mods/NTSymbiote/Ukrainian.xml"
  },
  ["3478084070"] = {
    name  = "NT Surgery Plus",
    files = "Mods/NTSurgeryPlus/Ukrainian.xml"
  },
  ["3247838390"] = {
    name  = "NT Pharmacy",
    files = {
      "Mods/NTPharmacy/Ukrainian.xml",
      "Mods/NTPharmacy/Overrides.xml"
    }
  },
  ["3294574390"] = {
    name  = "NT Eyes",
    files = "Mods/NTEyes/Ukrainian.xml"
  },

  -- Other gameplay/immersion mods
  ["3393519245"] = {
    name  = "Traumatic Presence",
    files = "Mods/TraumaticPresence/Ukrainian.xml"
  },
  ["3384404945"] = {
    name  = "Hunter's Husk Job",
    files = {
      "Mods/HuntersHuskJob/Ukrainian.xml",
      "Mods/HuntersHuskJob/Overrides.xml",
      "Mods/HuntersHuskJob/HHConversations.xml"
    }
  },
  ["2085783214"] = {
    name  = "Improved Husks",
    files = "Mods/ImprovedHusks/Ukrainian.xml"
  },
  ["2954998725"] = {
    name  = "Hungry Europans",
    files = {
      "Mods/HungryEuropans/Ukrainian.xml",
      "Mods/HungryEuropans/Overrides.xml"
    }
  },

  -- Balance/overhaul/gear
  ["3279470465"] = {
    name  = "Baroverhaul",
    files = "Mods/Baroverhaul/Ukrainian.xml"
  },
  ["2936760984"] = {
    name  = "Real Sonar",
    files = {
      "Mods/RealSonar/Conversations_Ukrainian.xml",
      "Mods/RealSonar/Info_Ukrainian.xml"
    }
  },
  ["3074045632"] = {
    name  = "Immersive Diving Gear",
    files = "Mods/ImmersiveDivingGear/Ukrainian.xml"
  },

  -- Enhanced Reactors family
  ["3045796581"] = {
    name  = "Enhanced Reactors",
    files = {
      "Mods/EnhancedReactors/Ukrainian.xml",
      "Mods/EnhancedReactors/Overrides.xml"
    }
  },
  ["3074045632"] = {
    name  = "Immersive Diving Gear – Enhanced Reactors Patch",
    files = "Mods/ImmersiveDivingGear/Ukrainian.xml"
  },
  ["3354732876"] = {
    name  = "Enhanced Reactors – Reactor Management",
    files = "Mods/EnhancedReactorsReactorManagement/Ukrainian.xml"
  },

  ["2968896556"] = {
    name  = "Enhanced Immersion",
    files = "Mods/EnhancedImmersion/Ukrainian.xml"
  },
  ["2347002377"] = {
    name  = "Sounds of Europa",
    files = "Mods/SoundsOfEuropa/Ukrainian.xml"
  },

  -- Immersive suite
  ["3114087512"] = {
    name  = "Immersive Repairs",
    files = {
      "Mods/ImmersiveRepairs/Ukrainian.xml",
      "Mods/ImmersiveRepairs/Overrides.xml"
    }
  },
  ["3239164008"] = {
    name  = "Immersive Crates",
    files = {
      "Mods/ImmersiveCrates/Ukrainian.xml",
      "Mods/ImmersiveCrates/Overrides.xml"
    }
  },
  ["3217556378"] = {
    name  = "Immersive Ignitibles",
    files = {
      "Mods/ImmersiveIgnitibles/Ukrainian.xml",
      "Mods/ImmersiveIgnitibles/Overrides.xml"
    }
  },

  -- Misc
  ["3153737715"] = {
    name  = "Soundproof Walls",
    files = "Mods/SoundproofWalls/Ukrainian.xml"
  },
  ["2947479333"] = {
    name  = "Simple Gene Rebalance",
    files = "Mods/SimpleGeneRebalance/Ukrainian.xml"
  },

  -- Artifacts & weapons packs
  ["3218219821"] = {
    name  = "Artifacts and Ruins Enchanced",
    files = {
      "Mods/ArtifactsAndRuinsEnchanced/Ukrainian.xml",
      "Mods/ArtifactsAndRuinsEnchanced/Overrides.xml"
    }
  },
  ["2613901395"] = {
    name  = "Backpacks",
    files = "Mods/Backpacks/Ukrainian.xml"
  },
  ["2900879567"] = {
    name  = "More Unique Weapons",
    files = {
      "Mods/MoreUniqueWeapons/Ukrainian.xml",
      "Mods/MoreUniqueWeapons/Overrides.xml"
    }
  },
}
