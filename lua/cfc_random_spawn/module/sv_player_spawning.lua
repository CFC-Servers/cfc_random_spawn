
CFCRandomSpawn = CFCRandomSpawn or {}

local customSpawnsForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]
local mapHasCustomSpawns = customSpawnsForMap ~= nil

if not mapHasCustomSpawns then return end

CFCRandomSpawn.spawnPointRankings = CFCRandomSpawn.spawnPointRankings or {}

local function getMeasurablePlayers( respawner )
    local measurablePlayers = {}
    for _, ply in pairs( player.GetHumans() ) do
        if ply:Alive() and respawner ~= ply then
            table.insert( measurablePlayers, ply )
        end
    end

    return measurablePlayers
end


-- Only use spawnpoints that are nearest to the most "popular" point
-- This lets everyone spawn near the most active part of the server

-- if count is hit and distance is not hit, more spawnpoints will be chosen & vice versa

local nearSpawnpointsMinCount = 8 -- minimum count of spawnpoints that will be availiable
local nearSpawnpointsMinDistance = 2500 -- minimum size of area that spawnpoints will be chosen from
local nearSpawnpointsMinDistanceSqr = nearSpawnpointsMinDistance ^ 2

local function sortSpawnsByDistance( comparePos, spawns )
    table.sort( spawns, function( a, b ) -- sort by distance
        local aDist = a.spawnPos:DistToSqr( comparePos )
        local bDist = b.spawnPos:DistToSqr( comparePos )
        return aDist < bDist
    end )
    return spawns
end

local function getNearestSpawns( nearPos, spawns )
    local distSortedSpawns = sortSpawnsByDistance( nearPos, spawns )
    local bestSpawn = distSortedSpawns[1] -- get best spawn so the distance comparison isnt worthless
    local nearestSpawns = {}

    for currOperation, spawn in pairs( distSortedSpawns ) do
        local distToFirstSqr = bestSpawn.spawnPos:DistToSqr( spawn.spawnPos ) -- will never run on every spawnpoint
        local overCount = currOperation >= nearSpawnpointsMinCount
        local overDistance = distToFirstSqr > nearSpawnpointsMinDistanceSqr

        if overCount and overDistance then
            break
        else
            table.insert( nearestSpawns, spawn )
        end
    end
    return nearestSpawns
end

local function getPopularPoint( players )
    if players == nil then return Vector() end
    local average = Vector()
    local playersCount = #players
    for _, currentPlayer in ipairs( players ) do
        if IsValid( currentPlayer ) then
            average = average + currentPlayer:GetPos()
        end
    end
    average = average / playersCount

    -- debugoverlay.Cross( average, 200, 100, Color( 255, 255, 255 ), true )

    return average
end


-- This is operating on a model of spawn points and players as electrons putting a force on each other
-- The best spawn point is the spawn point under the smallest sum of forces then. This is why we use physics terms here
local distSqr = 900 -- ( 30^2 )
local randMin, randMax = 1, 4

local function getPlayerForceFromCustomSpawn( spawn, measurablePlayers )
    local totalDistanceSquared = 0

    for _, ply in pairs( measurablePlayers ) do
        local plyDistanceSqr = ( ply:GetPos():DistToSqr( spawn ) )
        if plyDistanceSqr < distSqr then plyDistanceSqr = 1 end
        totalDistanceSquared = totalDistanceSquared + 1 / plyDistanceSqr
    end

    return totalDistanceSquared
end

function CFCRandomSpawn.getOptimalSpawnPosition()
    local randomSpawn = math.random( randMin, randMax )
    local spawnPoinTbl = CFCRandomSpawn.spawnPointRankings[randomSpawn]
    return spawnPoinTbl.spawnPos, spawnPoinTbl.spawnAngle
end

function CFCRandomSpawn.updateSpawnPointRankings( ply )
    local playerIDSFromSpawns = {}
    local measurablePlayers = getMeasurablePlayers( ply )

    popularPoint = getPopularPoint( measurablePlayers )

    bestSpawns = getNearestSpawns( popularPoint, customSpawnsForMap )

    for _, spawn in ipairs( bestSpawns ) do
        local spawnPosition = spawn.spawnPos
        local playerNetForce = getPlayerForceFromCustomSpawn( spawnPosition, measurablePlayers )
        local spawnDistanceData = {}
        spawnDistanceData.spawnPos = spawnPosition
        spawnDistanceData.spawnAngle = spawn.spawnAngle
        spawnDistanceData["inverse-distance-squared"] = playerNetForce

        table.insert( playerIDSFromSpawns, spawnDistanceData ) -- IDS == Inverse Distance Squared

        CFCRandomSpawn.spawnPointRankings = playerIDSFromSpawns
        table.SortByMember( CFCRandomSpawn.spawnPointRankings, "inverse-distance-squared", true )
    end

    --timer.Create( "CFC_UpdateOptimalSpawnPosition", 0.5, 0, CFCRandomSpawn.updateSpawnPointRankings )
end

function CFCRandomSpawn.handlePlayerSpawn( ply )
    if not ( ply and IsValid( ply ) ) then return end
    if IsValid( ply.LinkedSpawnPoint ) then return end

    CFCRandomSpawn.updateSpawnPointRankings( ply )
    local optimalSpawnPosition, optimalSpawnAngles  = CFCRandomSpawn.getOptimalSpawnPosition()

    ply:SetPos( optimalSpawnPosition )
    if optimalSpawnAngles then
        ply:SetEyeAngles( optimalSpawnAngles )
    end
end

hook.Add( "PlayerSpawn", "CFC_PlayerSpawning", CFCRandomSpawn.handlePlayerSpawn )
