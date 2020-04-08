CFCRandomSpawn = CFCRandomSpawn or {}
CFCRandomSpawn.Config = CFCRandomSpawn.Config or {}

AddCSLuaFile "cfc_random_spawn/sh_config.lua"

include "cfc_random_spawn/sh_config.lua"

if SERVER then
    include "cfc_random_spawn/module/sv_player_spawning.lua"
end
