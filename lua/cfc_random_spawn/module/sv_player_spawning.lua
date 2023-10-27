CFCRandomSpawn = CFCRandomSpawn or {}

local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()] or {}
local mapHasCustomSpawns = next( customSpawnConfigForMap )

local customSpawnsForMap = customSpawnConfigForMap.spawnpoints or {}
local pvpCenters = customSpawnConfigForMap.pvpCenters or {}
local DEFAULT_CENTER_CUTOFF = customSpawnConfigForMap.centerCutoff or CFCRandomSpawn.Config.DEFAULT_CENTER_CUTOFF
local DEFAULT_CENTER_CUTOFF_SQR = DEFAULT_CENTER_CUTOFF ^ 2
local CENTER_CUTOFF_SQR = DEFAULT_CENTER_CUTOFF_SQR
local SELECTION_SIZE = CFCRandomSpawn.Config.SELECTION_SIZE
local CLOSENESS_LIMIT = CFCRandomSpawn.Config.CLOSENESS_LIMIT ^ 2
local CENTER_UPDATE_INTERVAL = customSpawnConfigForMap.centerUpdateInterval or CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL
local IGNORE_BUILDERS = CFCRandomSpawn.Config.IGNORE_BUILDERS
local CENTER_UPDATE_ON_RESPAWN = CENTER_UPDATE_INTERVAL <= 0

local DYNAMIC_CENTER_MINDIST = 1750 -- getDynamicPvpCenter starts at this radius
local DYNAMIC_CENTER_MINSPAWNS = 10 -- getDynamicPvpCenter needs at least this many spawns inside the radius 

local function defaultPvpCenter()
    if pvpCenters[1] then return pvpCenters[1] end

end

local function loadPvpCenters()
    if not pvpCenters or not defaultPvpCenter() then
        CFCRandomSpawn.doDynamicCenters = true
    end

    for _, centerData in pairs( pvpCenters ) do
        local overrideCutoff = centerData.overrideCutoff

        if overrideCutoff then
            centerData.overrideCutoffSqr = overrideCutoff ^ 2
        end
    end

    CFCRandomSpawn.mostPopularCenter = defaultPvpCenter()
end

loadPvpCenters()

local mostPopularCenter = CFCRandomSpawn.mostPopularCenter

function CFCRandomSpawn.refreshMapInfo()
    mostPopularCenter = CFCRandomSpawn.mostPopularCenter
    customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]
    mapHasCustomSpawns = next( customSpawnConfigForMap )

    if not mapHasCustomSpawns then return end
    customSpawnsForMap = customSpawnConfigForMap.spawnpoints or {}
    pvpCenters = customSpawnConfigForMap.pvpCenters or {}
    DEFAULT_CENTER_CUTOFF = customSpawnConfigForMap.centerCutoff or CFCRandomSpawn.Config.DEFAULT_CENTER_CUTOFF
    DEFAULT_CENTER_CUTOFF_SQR = DEFAULT_CENTER_CUTOFF ^ 2
    CENTER_CUTOFF_SQR = DEFAULT_CENTER_CUTOFF_SQR
    SELECTION_SIZE = CFCRandomSpawn.Config.SELECTION_SIZE
    CLOSENESS_LIMIT = CFCRandomSpawn.Config.CLOSENESS_LIMIT ^ 2
    CENTER_UPDATE_INTERVAL = customSpawnConfigForMap.centerUpdateInterval or CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL
    IGNORE_BUILDERS = CFCRandomSpawn.Config.IGNORE_BUILDERS
    CENTER_UPDATE_ON_RESPAWN = CENTER_UPDATE_INTERVAL <= 0

    loadPvpCenters()
end

local function getPvpers()
    local pvpers = {}

    for _, ply in pairs( player.GetAll() ) do
        if not ply.IsInPvp or ply:IsInPvp() then
            table.insert( pvpers, ply )
        end
    end

    return pvpers
end

local function getMeasurablePlayers()
    local measurablePlayers = {}
    local humans = IGNORE_BUILDERS and getPvpers() or player.GetAll()

    for _, ply in pairs( humans ) do
        if ply:Alive() then
            table.insert( measurablePlayers, ply )
        end
    end

    return measurablePlayers
end

local function getLivingPlayers()
    local livingPlayers = {}
    local humans = player.GetAll()

    for _, ply in pairs( humans ) do
        if ply:Alive() then
            table.insert( livingPlayers, ply )
        end
    end

    return livingPlayers
end

local function getNearestSpawn( nearPos, spawns )
    local nearestSpawn
    local closestDistSqr = math.huge
    for _, spawn in ipairs( spawns ) do
        local distToNearSqr = spawn.spawnPos:DistToSqr( nearPos )
        if distToNearSqr < closestDistSqr then
            closestDistSqr = distToNearSqr
            nearestSpawn = spawn
        end
    end

    if not nearestSpawn then return spawns[1] end

    return nearestSpawn
end

local function spawnsSortedByDistTo( nearPos, spawns )
    local sortedSpawnsAndDistances = {}
    for _, spawn in ipairs( spawns ) do
        local dist = nearPos:DistToSqr( spawn.spawnPos )
        if dist < CENTER_CUTOFF_SQR then
            table.insert( sortedSpawnsAndDistances, { spawn = spawn, dist = dist } )
        end
    end

    table.sort( sortedSpawnsAndDistances, function( a, b ) return a.dist < b.dist end )
    return sortedSpawnsAndDistances
end

-- Get the first SELECTION_SIZE spawns that are closest to nearPos and are within range of CENTER_CUTOFF_SQR
local function getNearestSpawns( nearPos, spawns )
    local sortedSpawns = spawnsSortedByDistTo( nearPos, spawns )

    local nearestSpawns = {}
    for i = 1, SELECTION_SIZE do
        if sortedSpawns[i] then
            table.insert( nearestSpawns, sortedSpawns[i].spawn )
        end
    end

    -- If there are no good near points, just return all possible spawnpoints.
    if #nearestSpawns == 0 then return spawns end

    return nearestSpawns
end

local function findFreeSpawnPoints( spawns, plys )
    if CLOSENESS_LIMIT == 0 then return spawns end

    local trimmedSpawns = {}

    for _, spawn in ipairs( spawns ) do
        local spawnPos = spawn.spawnPos
        local plyTooClose = false

        for _, ply in ipairs( plys ) do
            if ply:GetPos():DistToSqr( spawnPos ) < CLOSENESS_LIMIT then
                plyTooClose = true
                break
            end
        end

        if not plyTooClose then
            table.insert( trimmedSpawns, spawn )
        end
    end

    if #trimmedSpawns == 0 then return spawns end -- If all spawnpoints are full, just return all of them. Super rare case.

    return trimmedSpawns
end

local function getPlyAvg( plys, centerPos )
    if not plys or not plys[1] then return centerPos or Vector() end

    local avgSum = Vector()
    local count = 0

    for _, ply in ipairs( plys ) do
        local plyPos = ply:GetPos()

        if centerPos then
            if centerPos:DistToSqr( plyPos ) <= CENTER_CUTOFF_SQR then
                avgSum = avgSum + plyPos
                count = count + 1
            end
        else
            avgSum = avgSum + plyPos
            count = count + 1
        end
    end

    if count == 0 then return centerPos end

    return avgSum / count
end

-- Players within the point's radius each provide a score of 1, while players outside the radius provide a score that falls off quadratically
local function getPlayerPopularityFromPoint( point, plys, radiusSqr )
    local totalScore = 0
    radiusSqr = radiusSqr or DEFAULT_CENTER_CUTOFF_SQR

    for _, ply in pairs( plys ) do
        local plyDistanceSqr = ( ply:GetPos():DistToSqr( point ) )

        if plyDistanceSqr < radiusSqr then plyDistanceSqr = radiusSqr end

        totalScore = totalScore + radiusSqr / plyDistanceSqr
    end

    return totalScore
end

local function getDynamicPvpCenter( measurablePlayers )
    local playersAveragePos = Vector( 0, 0, 0 )
    for _, ply in ipairs( measurablePlayers ) do
        playersAveragePos = playersAveragePos + ply:GetPos()
    end

    playersAveragePos = playersAveragePos / #measurablePlayers

    local closestSpawnToAverage = getNearestSpawn( playersAveragePos, customSpawnsForMap )
    -- use nearest spawnpoint as a sanity point
    local dynamicPvpCenter = {}
    dynamicPvpCenter.centerPos = closestSpawnToAverage.spawnPos

    -- sorted spawns for cutoff dist stuff
    local spawnsSortedToClosest = spawnsSortedByDistTo( dynamicPvpCenter.centerPos, customSpawnsForMap )

    -- now determine the cutoff dist
    local cutoffDistSqr = DYNAMIC_CENTER_MINDIST^2
    local foundCount = 0
    for _, spawnAndDist in ipairs( spawnsSortedToClosest ) do
        foundCount = foundCount + 1
        if spawnAndDist.dist > cutoffDistSqr and foundCount >= DYNAMIC_CENTER_MINSPAWNS then
            cutoffDistSqr = spawnAndDist.dist
            break
        end
    end

    dynamicPvpCenter.overrideCutoff = math.sqrt( cutoffDistSqr )
    dynamicPvpCenter.overrideCutoffSqr = cutoffDistSqr

    debugoverlay.Sphere( closestSpawnToAverage.spawnPos, dynamicPvpCenter.overrideCutoff, 10, color_white )

    return dynamicPvpCenter
end

-- Gets the most popular pvp center via the electron force model, to eliminate outliers
local function getPopularCenter( plys )
    local bestScore = -1
    local bestCenter = { centerPos = Vector() }

    if not pvpCenters[2] then return defaultPvpCenter() end -- No need to make extra calculations if there's only one pvp center
    if not plys or not plys[1] then return defaultPvpCenter() end -- Use the first pvp center as the primary one if there are no pvpers

    for _, center in ipairs( pvpCenters ) do
        local score = getPlayerPopularityFromPoint( center.centerPos, plys, center.overrideCutoffSqr )

        if score > bestScore then
            bestScore = score
            bestCenter = center
        end
    end

    return bestCenter
end

local function updatePopularCenter( measurablePlayers )
    if CFCRandomSpawn.doDynamicCenters then
        mostPopularCenter = getDynamicPvpCenter( measurablePlayers )
        PrintTable( mostPopularCenter )
        print( "a" )
    else
        mostPopularCenter = getPopularCenter( measurablePlayers )
    end
    CFCRandomSpawn.mostPopularCenter = mostPopularCenter

    CENTER_CUTOFF = mostPopularCenter.overrideCutoff or DEFAULT_CENTER_CUTOFF
    CENTER_CUTOFF_SQR = mostPopularCenter.overrideCutoffSqr or DEFAULT_CENTER_CUTOFF_SQR
end

function CFCRandomSpawn.getOptimalSpawnPos()
    local measurablePlayers = getMeasurablePlayers()
    local allLivingPlys = getLivingPlayers()

    if CENTER_UPDATE_ON_RESPAWN or not CFCRandomSpawn.mostPopularCenter then
        updatePopularCenter( measurablePlayers )
    end

    local freeSpawns = findFreeSpawnPoints( customSpawnsForMap, allLivingPlys )
    local nearestSpawns = getNearestSpawns( getPlyAvg( measurablePlayers, CFCRandomSpawn.mostPopularCenter.centerPos ), freeSpawns )
    local bestSpawn = nearestSpawns[math.random( 1, #nearestSpawns )]

    return bestSpawn.spawnPos, bestSpawn.spawnAngle
end

function CFCRandomSpawn.handlePlayerSpawn( ply )
    if not mapHasCustomSpawns then return end
    if not ( ply and IsValid( ply ) ) then return end
    if IsValid( ply.LinkedSpawnPoint ) then return end

    local optimalSpawnPosition, optimalSpawnAngles = CFCRandomSpawn.getOptimalSpawnPos()

    ply:SetPos( optimalSpawnPosition )

    if optimalSpawnAngles then
        ply:SetEyeAngles( optimalSpawnAngles )
    end
end

hook.Add( "PlayerSpawn", "CFC_RandomSpawn_ChooseOptimalSpawnpoint", CFCRandomSpawn.handlePlayerSpawn )


if not CENTER_UPDATE_ON_RESPAWN then
    timer.Create( "CFC_RandomSpawn_CalculateMostPopularPvpCenter", CENTER_UPDATE_INTERVAL, 0, function()
        if not mapHasCustomSpawns then return end
        local measurablePlayers = getMeasurablePlayers()

        updatePopularCenter( measurablePlayers )
    end )
end
