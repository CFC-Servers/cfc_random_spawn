CFCRandomSpawn = CFCRandomSpawn or {}

local customSpawnsForMap = CFCRandomSpawn.config.CUSTOM_SPAWNS[game.GetMap()]
local mapHasCustomSpawns = customSpawnsForMap ~= nil

hook.Remove( "PlayerSpawn", "CFC_PlayerSpawning" )

if not mapHasCustomSpawns then return end

CFCRandomSpawn.spawnPointRankings = CFCRandomSpawn.spawnPointRankings or {}

local function getMeasurablePlayers()
    local measurablePlayers = {}
    for _, ply in pairs( player.GetHumans() ) do
        if ( ply:Alive() ) then
            table.insert( measurablePlayers, ply )
        end
    end

    return measurablePlayers
end

-- This is operating on a model of spawn points and players as electrons putting a force on each other
-- The best spawn point is the spawn point under the smallest sum of forces then. This is why we use physics terms here
local distSqr = 900 -- ( 30^2 )
local randMin, randMax = 1, 4
local function getPlayerForceFromCustomSpawn( spawn )
    local totalDistanceSquared = 0
    local measurablePlayers = getMeasurablePlayers()

    for _, ply in pairs( measurablePlayers ) do
        local plyDistanceSqr = ( ply:GetPos():DistToSqr( spawn ) )
        if plyDistanceSqr < distSqr then plyDistanceSqr = 1 end
        totalDistanceSquared = totalDistanceSquared + 1 / plyDistanceSqr
    end

    return totalDistanceSquared
end

function CFCRandomSpawn.getOptimalSpawnPosition()
    local randomSpawn = math.random( randMin, randMax )
    return CFCRandomSpawn.spawnPointRankings[randomSpawn]["spawn_pos"]
end

function CFCRandomSpawn.updateSpawnPointRankings( ply )
    local playerIDSFromSpawns = {}
    local playerPVPStatus = ply:GetNWBool( "CFC_PvP_Mode", false )

    for _, spawn in pairs( customSpawnsForMap ) do
        local isPvpSpawn = spawn["isPvpSpawn"]

        if playerPVPStatus and isPvpSpawn then
            local spawnPosition = spawn["spawn_pos"]
            local playerNetForce = getPlayerForceFromCustomSpawn( spawnPosition )
            local spawnDistanceData = {}
            spawnDistanceData["spawn"] = spawnPosition
            spawnDistanceData["inverse-distance-squared"] = playerNetForce

            table.insert( playerIDSFromSpawn, spawnDistanceData ) -- IDS == Inverse Distance Squared
        end
        CFCRandomSpawn.spawnPointRankings = playerIDSFromSpawns
        table.SortByMember( CFCRandomSpawn.spawnPointRankings, "inverse-distance-squared", true )
    end

    -- timer.Create( "CFC_UpdateOptimalSpawnPosition", 0.5, 0, CFCRandomSpawn.updateSpawnPointRankings )
end

function CFCRandomSpawn.handlePlayerSpawn( ply )
    if not ( ply and IsValid( ply ) ) then return end
    if ply.LinkedSpawnPoint then return end

    CFCRandomSpawn.updateSpawnPointRankings( ply )
    local optimalSpawnPosition = CFCRandomSpawn.getOptimalSpawnPosition()

    ply:SetPos( optimalSpawnPosition )
end

hook.Add( "PlayerSpawn", "CFC_PlayerSpawning", CFCRandomSpawn.handlePlayerSpawn )

