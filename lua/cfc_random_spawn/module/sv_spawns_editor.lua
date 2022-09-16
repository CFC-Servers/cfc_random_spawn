util.AddNetworkString( "CFC_SpawnEditor_SendSpawnPoints" )
util.AddNetworkString( "CFC_SpawnEditor_RequestSpawnPoints" )
util.AddNetworkString( "CFC_SpawnEditor_UpdateSpawnPoints" )

net.Receive( "CFC_SpawnEditor_RequestSpawnPoints", function( _, ply )
    if not ply:IsAdmin() then return end
    local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]

    if not customSpawnConfigForMap then return end

    net.Start( "CFC_SpawnEditor_SendSpawnPoints" )
    net.WriteTable( customSpawnConfigForMap )
    net.Send( ply )
end )

net.Receive( "CFC_SpawnEditor_UpdateSpawnPoints", function( _, ply )
    if not ply:IsAdmin() then return end
    local newSpawnTable = net.ReadTable()
    if not newSpawnTable then return end

    CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()] = newSpawnTable
    CFCRandomSpawn.refreshMapInfo()
end )
