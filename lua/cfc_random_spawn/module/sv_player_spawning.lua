CFCRandomSpawn = CFCRandomSpawn or {}

local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]
local mapHasCustomSpawns = customSpawnConfigForMap ~= nil

if not mapHasCustomSpawns then return end

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

do
    if not pvpCenters or not pvpCenters[1] then
        local avgSum = Vector()
        local count = #customSpawnsForMap

        for i = 1, count do
            avgSum = avgSum + customSpawnsForMap[i]
        end

        pvpCenters = pvpCenters or {}
        pvpCenters[1] = {
            centerPos = avgSum / count
        }

        customSpawnConfigForMap.pvpCenters = pvpCenters
    end

    for _, centerData in pairs( pvpCenters ) do
        local overrideCutoff = centerData.overrideCutoff

        if overrideCutoff then
            centerData.overrideCutoffSqr = overrideCutoff ^ 2
        end
    end

    CFCRandomSpawn.mostPopularCenter = pvpCenters[1]
end

local mostPopularCenter = CFCRandomSpawn.mostPopularCenter
local centerWasDefaulted = false

local function getPvpers()
    local pvpers = {}
    local count = 0

    for _, ply in pairs( player.GetHumans() ) do
        if ply.IsInPvp and ply:IsInPvp() then
            count = count + 1
            pvpers[count] = ply
        end
    end

    return pvpers
end

local function getMeasurablePlayers( respawner )
    local measurablePlayers = {}
    local humans = IGNORE_BUILDERS and getPvpers() or player.GetHumans()

    for _, ply in pairs( humans ) do
        if ply:Alive() and respawner ~= ply then
            table.insert( measurablePlayers, ply )
        end
    end

    return measurablePlayers
end

local function getLivingPlayers( respawner )
    local livingPlayers = {}
    local humans = player.GetHumans()
    local count = 0

    for _, ply in pairs( humans ) do
        if ply:Alive() and respawner ~= ply then
            count = count + 1
            livingPlayers[count] = ply
        end
    end

    return livingPlayers
end

-- Get the first SELECTION_SIZE spawns that are closest to nearPos and are within range of CENTER_CUTOFF_SQR
-- Does manual comparisons instead of table.sort for efficiency
local function getNearestSpawns( nearPos, spawns )
    local tempDistanceTable = {}
    for _, spawn in ipairs( spawns ) do
        local dist = nearPos:DistToSqr( spawn.spawnPos )
        if dist < CENTER_CUTOFF_SQR then
            table.insert( tempDistanceTable, { spawn = spawn, dist = dist } )
        end
    end

    table.sort( tempDistanceTable, function( a, b ) return a.dist < b.dist end )

    local nearestSpawns = {}
    for i = 1, SELECTION_SIZE do
        table.insert( nearestSpawns, tempDistanceTable[i].spawn )
    end

    return nearestSpawns
end

local function discardTooCloseSpawns( spawns, plys )
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

    if #trimmedSpawns == 0 then return spawns end -- Unfortunately, *all* spawns were too close. We gotta return something, though.

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

-- Gets the most popular pvp center via the electron force model, to eliminate outliers
local function getPopularCenter( plys )
    local bestScore = -1
    local bestCenter = { centerPos = Vector() }

    if not pvpCenters[2] then return pvpCenters[1] end -- No need to make extra calculations if there's only one pvp center
    if not plys or not plys[1] then return pvpCenters[1] end -- Use the first pvp center as the primary one if there are no pvpers

    for _, center in ipairs( pvpCenters ) do
        local score = getPlayerPopularityFromPoint( center.centerPos, plys, center.overrideCutoffSqr )

        if score > bestScore then
            bestScore = score
            bestCenter = center
        end
    end

    return bestCenter
end

function CFCRandomSpawn.getOptimalSpawnPos( ply )
    local measurablePlayers = getMeasurablePlayers( ply )
    local allLivingPlys = getLivingPlayers( ply )

    if CENTER_UPDATE_ON_RESPAWN then
        mostPopularCenter = getPopularCenter( measurablePlayers ) or pvpCenters[1]
        CFCRandomSpawn.mostPopularCenter = mostPopularCenter

        CENTER_CUTOFF = mostPopularCenter.overrideCutoff or DEFAULT_CENTER_CUTOFF
        CENTER_CUTOFF_SQR = mostPopularCenter.overrideCutoffSqr or DEFAULT_CENTER_CUTOFF_SQR
    end

    local nearestSpawns = getNearestSpawns( getPlyAvg( measurablePlayers, mostPopularCenter.centerPos ), customSpawnsForMap )
    local bestSpawns = discardTooCloseSpawns( nearestSpawns, allLivingPlys )
    local bestSpawn = bestSpawns[math.random( 1, #bestSpawns )]

    return bestSpawn.spawnPos, bestSpawn.spawnAngle
end

function CFCRandomSpawn.handlePlayerSpawn( ply )
    if not ( ply and IsValid( ply ) ) then return end
    if IsValid( ply.LinkedSpawnPoint ) then return end

    local optimalSpawnPosition, optimalSpawnAngles  = CFCRandomSpawn.getOptimalSpawnPos( ply )

    ply:SetPos( optimalSpawnPosition )

    if optimalSpawnAngles then
        ply:SetEyeAngles( optimalSpawnAngles )
    end
end

hook.Add( "PlayerSpawn", "CFC_RandomSpawn_ChooseOptimalSpawnpoint", CFCRandomSpawn.handlePlayerSpawn )


if not CENTER_UPDATE_ON_RESPAWN then
    timer.Create( "CFC_RandomSpawn_CalculateMostPopularPvpCenter", CENTER_UPDATE_INTERVAL, 0, function()
        local measurablePlayers = getMeasurablePlayers()

        if measurablePlayers[1] then
            mostPopularCenter = getPopularCenter( measurablePlayers ) or pvpCenters[1]
            centerWasDefaulted = false
        else
            -- There are no measureable players, so reset back to what should be the intended main pvp area
            if centerWasDefaulted then return end -- Redundancy check

            mostPopularCenter = pvpCenters[1]
            centerWasDefaulted = true
        end

        CFCRandomSpawn.mostPopularCenter = mostPopularCenter

        CENTER_CUTOFF_SQR = mostPopularCenter.overrideCutoffSqr or DEFAULT_CENTER_CUTOFF_SQR
    end )
end
