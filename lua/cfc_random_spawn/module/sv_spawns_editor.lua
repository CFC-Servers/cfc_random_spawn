util.AddNetworkString( "CFC_SpawnEditor_SendSpawnPoints" )
util.AddNetworkString( "CFC_SpawnEditor_RequestSpawnPoints" )

net.Receive( "CFC_SpawnEditor_RequestSpawnPoints", function( _, ply )
    if not ply:IsAdmin() then return end
    local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]

    net.Start( "CFC_SpawnEditor_SendSpawnPoints" )
    net.WriteTable( customSpawnConfigForMap )
    net.Send( ply )
end )
