CFCRandomSpawn = CFCRandomSpawn or {}
CFCRandomSpawn.Config = CFCRandomSpawn.Config or {}

AddCSLuaFile( "cfc_random_spawn/module/cl_spawns_editor.lua" )

include( "cfc_random_spawn/sv_config.lua" )

hook.Add( "InitPostEntity", "CFCRandomSpawn_Init", function()
    include( "cfc_random_spawn/module/sv_player_spawning.lua" )
    include( "cfc_random_spawn/module/sv_spawns_editor.lua" )
end )
