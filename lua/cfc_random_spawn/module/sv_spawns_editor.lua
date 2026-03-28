util.AddNetworkString( "CFC_SpawnEditor_SendSpawnPoints" )
util.AddNetworkString( "CFC_SpawnEditor_RequestSpawnPoints" )
util.AddNetworkString( "CFC_SpawnEditor_UpdateSpawnPoints" )
util.AddNetworkString( "CFC_SpawnEditor_SyncActivePvpCenter" )
util.AddNetworkString( "CFC_SpawnEditor_SetEditing" )

CFCRandomSpawn.EditingPlayers = CFCRandomSpawn.EditingPlayers or {}

function CFCRandomSpawn.syncActivePvpCenter()
    local activePvpCenter = CFCRandomSpawn.activePvpCenter
    if not activePvpCenter then return end

    net.Start( "CFC_SpawnEditor_SyncActivePvpCenter" )
        net.WriteVector( activePvpCenter.centerPos )
        net.WriteFloat( activePvpCenter.radius )
        net.WriteUInt( activePvpCenter.zoneID, 10 )
    net.Send( CFCRandomSpawn.EditingPlayers )
end

net.Receive( "CFC_SpawnEditor_RequestSpawnPoints", function( _, ply )
    if not ply:IsAdmin() then return end
    local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]

    if not customSpawnConfigForMap then return end

    CFCRandomSpawn.syncActivePvpCenter()

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

net.Receive( "CFC_SpawnEditor_SetEditing", function( _, ply )
    if not ply:IsAdmin() then return end

    if net.ReadBool() then
        if not table.HasValue( CFCRandomSpawn.EditingPlayers ) then
            table.insert( CFCRandomSpawn.EditingPlayers, ply )
        end
    else
        table.RemoveByValue( CFCRandomSpawn.EditingPlayers, ply )
    end
end )
