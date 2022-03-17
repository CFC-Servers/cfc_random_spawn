CFCRandomSpawn = CFCRandomSpawn or {}

local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]
local mapHasCustomSpawns = customSpawnConfigForMap ~= nil

if not mapHasCustomSpawns then return end

local customSpawnsForMap = customSpawnConfigForMap.spawnpoints
local pvpCenters = customSpawnConfigForMap.pvpCenters
local CENTER_CUTOFF = customSpawnConfigForMap.centerCutoff or CFCRandomSpawn.Config.DEFAULT_CENTER_CUTOFF
local CENTER_CUTOFF_SQR = CENTER_CUTOFF ^ 2
local AVG_CUTOFF_SQR = CENTER_CUTOFF_SQR
local SELECTION_SIZE = CFCRandomSpawn.Config.SELECTION_SIZE
local CLOSENESS_LIMIT = CFCRandomSpawn.Config.CLOSENESS_LIMIT ^ 2
local IGNORE_BUILDERS = CFCRandomSpawn.Config.IGNORE_BUILDERS

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
end

local function getPvpers()
    local pvpers = {}
    local count = 0

    for _, ply in pairs( player.GetHumans() ) do
        if ply.isInPvp and ply:isInPvp() then
            count = count + 1
            pvpers[count] = ply
        end
    end

    return pvpers
end

local function getMeasurablePlayers( respawner )
    local measurablePlayers = {}
    local humans = IGNORE_BUILDERS and getPvpers() or player.GetHumans()
    local count = 0

    for _, ply in pairs( humans ) do
        if ply:Alive() and respawner ~= ply then
            count = count + 1
            measurablePlayers[count] = ply
        end
    end

    return measurablePlayers
end

-- Get the first SELECTION_SIZE spawns that are closest to nearPos and are within range of CENTER_CUTOFF_SQR
-- Does manual comparisons instead of table.sort for efficiency
local function getNearestSpawns( nearPos, spawns )
    local nearestSpawns = {
        { dist = math.huge, spawnData = spawns[1] }
    }

    for i, spawn in pairs( spawns ) do
        local dist = nearPos:DistToSqr( spawn.spawnPos )

        for i2 = 1, SELECTION_SIZE do
            local compareSpawn = nearestSpawns[i2]

            if compareSpawn then
                if dist < compareSpawn.dist then
                    table.insert( nearestSpawns, i2, { dist = dist, spawnData = spawn } ) -- This spawn is closer, insert it

                    nearestSpawns[SELECTION_SIZE + 1] = nil -- Ensure excess spawns are purged

                    goto skipRemainingCompares
                end
            elseif dist < CENTER_CUTOFF_SQR then -- Nothing to compare against and this spawn is within the cutoff range
                nerestSpawns[i2] = { dist = dist, spawnData = spawn }
            end
        end

        ::skipRemainingCompares::
    end

    return nearestSpawns
end

local function discardTooCloseSpawns( spawns, plys )
    if CLOSENESS_LIMIT == 0 then return spawns end

    local oldSpawns = spawns
    local trimmedSpawns = {}
    local count = 0

    for _, spawn in ipairs( spawns ) do
        local spawnData = spawn.spawnData or spawn -- unwrap dist data from getNearestSpawns()
        local spawnPos = spawnData.spawnPos

        for _, ply in ipairs( plys ) do
            if ply:GetPos():DistToSqr( spawnPos ) < CLOSENESS_LIMIT then
                goto skipRemainingCompares
            end
        end

        count = count + 1
        trimmedSpawns[count] = spawnData

        ::skipRemainingCompares::
    end

    if count == 0 then return oldSpawns end -- Unfortunately, *all* spawns were too close. We gotta return something, though.

    return trimmedSpawns
end

local function getPlyAvg( plys, centerPos )
    if not plys or not plys[1] then return centerPos or Vector() end

    local avgSum = Vector()
    local count = 0

    for _, ply in ipairs( plys ) do
        local plyPos = ply:GetPos()

        if centerPos then
            if centerPos:DistToSqr( plyPos ) <= AVG_CUTOFF_SQR then
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

-- This is operating on a model of spawn points and players as electrons putting a force on each other
-- The best spawn point is the spawn point under the smallest sum of forces then. This is why we use physics terms here
local FORCE_DIST_MIN_SQR = 30 ^ 2 -- Distances below this will be clamped to the maximum force of 1

local function getPlayerForceFromPoint( point, plys )
    local totalForce = 0

    for _, ply in pairs( plys ) do
        local plyDistanceSqr = ( ply:GetPos():DistToSqr( point ) )

        if plyDistanceSqr < FORCE_DIST_MIN_SQR then plyDistanceSqr = 1 end

        totalForce = totalForce + 1 / plyDistanceSqr
    end

    return totalForce
end

-- Gets the most popular pvp center via the electron force model, to eliminate outliers
local function getPopularCenter( plys )
    local bestForce = -1
    local bestCenter = { centerPos = Vector() }

    if not pvpCenters[2] then return pvpCenters[1] end -- No need to make extra calculations if there's only one pvp center
    if not plys or not plys[1] then return pvpCenters[1] end -- Use the first pvp center as the primary one if there are no pvpers

    for i, center in ipairs( pvpCenters ) do
        local force = getPlayerForceFromPoint( center.centerPos, plys )

        if force > bestForce then
            bestForce = force
            bestCenter = center
        end
    end

    return bestCenter
end

function CFCRandomSpawn.getOptimalSpawnPos( ply, overrideInd )
    local measurablePlayers = getMeasurablePlayers( ply )
    local bestCenter = getPopularCenter( measurablePlayers )

    AVG_CUTOFF_SQR = bestCenter.overrideCutoffSqr or CENTER_CUTOFF_SQR

    local nearestSpawns = getNearestSpawns( getPlyAvg( measurablePlayers, bestCenter.centerPos ), customSpawnsForMap )
    local bestSpawns = discardTooCloseSpawns( nearestSpawns, measurablePlayers )
    local bestSpawn = bestSpawns[overrideInd or math.random( 1, #bestSpawns )]
    bestSpawn = bestSpawn.spawnData or bestSpawn -- unwrap dist data from getNearestSpawns() if still wrapped

    return bestSpawn.spawnPos, bestSpawn.spawnAngle
end

function CFCRandomSpawn.handlePlayerSpawn( ply )
    if not ( ply and IsValid( ply ) ) then return end
    if IsValid( ply.LinkedSpawnpoint ) then return end

    local optimalSpawnPosition, optimalSpawnAngles  = CFCRandomSpawn.getOptimalSpawnPos( ply )

    ply:SetPos( optimalSpawnPosition )

    if optimalSpawnAngles then
        ply:SetEyeAngles( optimalSpawnAngles )
    end
end

hook.Add( "PlayerSpawn", "CFC_PlayerSpawning", CFCRandomSpawn.handlePlayerSpawn )
