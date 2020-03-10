CFCRandomSpawn = CFCRandomSpawn or {}
CFCRandomSpawn.Config = CFCRandomSpawn.Config or {}

include "cfc_random_spawn/sh_config.lua"

if SERVER then
    include "cfc_random_spawn/mcodule/sv_player_spawning.lua"
end
