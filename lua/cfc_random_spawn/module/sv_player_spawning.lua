CFCRandomSpawn = CFCRandomSpawn or {}
CFCRandomSpawn.EditingPlayers = CFCRandomSpawn.EditingPlayers or {}

local customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()] or {}
local mapHasCustomSpawns = next( customSpawnConfigForMap )

local customSpawnsForMap = customSpawnConfigForMap.spawnpoints or {}
local zonesForMap = customSpawnConfigForMap.zones or {}
local DEFAULT_CENTER_RADIUS = CFCRandomSpawn.Config.DEFAULT_CENTER_RADIUS
local DEFAULT_CENTER_RADIUS_SQR = DEFAULT_CENTER_RADIUS ^ 2
local CENTER_RADIUS_SQR = DEFAULT_CENTER_RADIUS_SQR
local DYNAMIC_CENTER_FALLBACK = customSpawnConfigForMap.dynamicCenterStartingPos or Vector()
local SELECTION_SIZE = CFCRandomSpawn.Config.SELECTION_SIZE
local CLOSENESS_LIMIT = CFCRandomSpawn.Config.CLOSENESS_LIMIT ^ 2
local CENTER_UPDATE_INTERVAL = customSpawnConfigForMap.centerUpdateInterval or CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL
local IGNORE_BUILDERS = CFCRandomSpawn.Config.IGNORE_BUILDERS

local ACTIVE_PLAYER_TIMEOUT = 120 -- players who haven't died/killed anyone in this many seconds aren't 'pvping' and won't influence the pvp center, etc
local NO_ZONE_ID = 1

local DYNAMIC_CENTER_MINSIZE = 2000 -- getDynamicPvpCenter starts at this radius
local DYNAMIC_CENTER_MAXSIZE = 4000 -- no bigger than this radius
local DYNAMIC_CENTER_MINSPAWNS = 10 -- getDynamicPvpCenter needs at least this many spawns inside the radius
local DYNAMIC_CENTER_MAXSPAWNS = 35 -- max possible spawns
local DYNAMIC_CENTER_SPAWNCOUNTMATCHPVPERS = true -- pvp center gets bigger when more people are pvping
local DYNAMIC_CENTER_IMPERFECT = true -- throw a bit of randomness in, makes pvp less stiff.

CFCRandomSpawn.recentCombatants = CFCRandomSpawn.recentCombatants or {}
local recentCombatants = CFCRandomSpawn.recentCombatants
local noZones = false
local fallbackZoneID = nil

local spawnTraceResult = {}
local spawnTraceRequest = {
    mins = Vector( -16, -16, 0 ),
    maxs = Vector( 16, 16, 72 ),
    mask = MASK_PLAYERSOLID,
    collisiongroup = COLLISION_GROUP_PLAYER,
    ignoreworld = true, -- In case some spawns are clipped slightly but can be escaped with crouch. They still should get fixed up, though!
    output = spawnTraceResult,
}

local CurTime = CurTime
local Vector = Vector

util.AddNetworkString( "CFC_SpawnEditor_ActiveCenter" )

local function getZoneForPos( pos )
    if noZones then return NO_ZONE_ID end

    for zoneID, zone in ipairs( zonesForMap ) do
        if pos:WithinAABox( zone.cornerA, zone.cornerB ) then
            return zoneID
        end
    end

    return fallbackZoneID
end

local function loadZones()
    noZones = table.IsEmpty( zonesForMap )

    if noZones then
        fallbackZoneID = NO_ZONE_ID

        for _, spawn in ipairs( customSpawnsForMap ) do
            spawn.zoneID = fallbackZoneID
        end

        return
    end

    fallbackZoneID = #zonesForMap + 1

    for _, spawn in ipairs( customSpawnsForMap ) do
        spawn.zoneID = getZoneForPos( spawn.spawnPos )
    end
end

loadZones()

local activePvpCenter = CFCRandomSpawn.activePvpCenter

function CFCRandomSpawn.refreshMapInfo()
    activePvpCenter = CFCRandomSpawn.activePvpCenter
    customSpawnConfigForMap = CFCRandomSpawn.Config.CUSTOM_SPAWNS[game.GetMap()]
    mapHasCustomSpawns = next( customSpawnConfigForMap )

    if not mapHasCustomSpawns then return end
    customSpawnsForMap = customSpawnConfigForMap.spawnpoints or {}
    DEFAULT_CENTER_RADIUS = CFCRandomSpawn.Config.DEFAULT_CENTER_RADIUS
    DEFAULT_CENTER_RADIUS_SQR = DEFAULT_CENTER_RADIUS ^ 2
    CENTER_RADIUS = DEFAULT_CENTER_RADIUS
    CENTER_RADIUS_SQR = CENTER_RADIUS ^ 2
    SELECTION_SIZE = CFCRandomSpawn.Config.SELECTION_SIZE
    CLOSENESS_LIMIT = CFCRandomSpawn.Config.CLOSENESS_LIMIT ^ 2
    CENTER_UPDATE_INTERVAL = customSpawnConfigForMap.centerUpdateInterval or CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL
    IGNORE_BUILDERS = CFCRandomSpawn.Config.IGNORE_BUILDERS

    loadZones()
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

    local cur = CurTime()

    for _, ply in pairs( humans ) do
        if ply:Alive() and recentCombatants[ply] > cur then
            table.insert( measurablePlayers, ply )
        end
    end

    -- Retry without the combat check if no one's been active
    if #measurablePlayers == 0 then
        for _, ply in pairs( humans ) do
            if ply:Alive() then
                table.insert( measurablePlayers, ply )
            end
        end
    end

    return measurablePlayers
end

local function countAsCombatting( ply )
    local cur = CurTime()
    recentCombatants[ply] = cur + ACTIVE_PLAYER_TIMEOUT
end

hook.Add( "PlayerInitialSpawn", "cfc_randomspawn_firstspawn", function( ply )
    recentCombatants[ply] = 0
end )

hook.Add( "PlayerDeath", "cfc_randomspawn_trackrecentcombatants", function( died, _inflictor, attacker )
    if not attacker:IsPlayer() then return end
    countAsCombatting( died )
    countAsCombatting( attacker )
end )

hook.Add( "PlayerDisconnected", "cfc_randomspawn_cleanuprecentcombatants", function( ply )
    recentCombatants[ply] = nil
end )

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

local function isInZone( pos, zoneID )
    if noZones or zoneID == fallbackZoneID then return true end

    local zone = zonesForMap[zoneID]

    return pos:WithinAABox( zone.cornerA, zone.cornerB )
end

local function getNearestSpawn( nearPos, spawns )
    local nearestSpawn
    local closestDistSqr = math.huge
    for _, spawn in ipairs( spawns ) do
        local distToNearSqr = spawn.spawnPos:DistToSqr( nearPos )
        if distToNearSqr < closestDistSqr and isInZone( nearPos, spawn.zoneID ) then
            closestDistSqr = distToNearSqr
            nearestSpawn = spawn
        end
    end

    return nearestSpawn
end

local function spawnsSortedByDistTo( nearPos, spawns, radiusSqr, zoneID )
    local sortedSpawnsAndDistances = {}
    for _, spawn in ipairs( spawns ) do
        if zoneID == nil or spawn.zoneID == zoneID then
            local dist = nearPos:DistToSqr( spawn.spawnPos )
            if dist < radiusSqr then
                table.insert( sortedSpawnsAndDistances, { spawn = spawn, dist = dist } )
            end
        end
    end

    table.sort( sortedSpawnsAndDistances, function( a, b ) return a.dist < b.dist end )
    return sortedSpawnsAndDistances
end

local function getSpawnsInZone( spawns, zoneID )
    local filteredSpawns = {}

    for _, spawn in ipairs( spawns ) do
        if spawn.zoneID == zoneID then
            table.insert( filteredSpawns, spawn )
        end
    end

    return filteredSpawns
end

-- Get the first SELECTION_SIZE spawns that are closest to nearPos and are within range of CENTER_RADIUS_SQR
local cachedSpawnsInsideCenter    = nil
local nextSpawnsInsideCenterCache = 0

local function spawnsInsidePvpCenterCached( spawns )
    if cachedSpawnsInsideCenter and nextSpawnsInsideCenterCache > CurTime() then return cachedSpawnsInsideCenter end
    nextSpawnsInsideCenterCache = CurTime() + 7.5

    local center = CFCRandomSpawn.activePvpCenter
    local sortedSpawns = spawnsSortedByDistTo( center.centerPos, spawns, CENTER_RADIUS_SQR, center.zoneID )

    cachedSpawnsInsideCenter = {}
    for i = 1, SELECTION_SIZE do
        if sortedSpawns[i] then
            table.insert( cachedSpawnsInsideCenter, sortedSpawns[i].spawn )
        end
    end

    -- If there are no good near points, try all spawns in the zone.
    if #cachedSpawnsInsideCenter == 0 then
        cachedSpawnsInsideCenter = getSpawnsInZone( cachedSpawnsInsideCenter, center.zoneID )
    end

    -- If still empty, use all spawns.
    if #cachedSpawnsInsideCenter == 0 then
        cachedSpawnsInsideCenter = spawns
    end

    return cachedSpawnsInsideCenter
end

local function spawnIsFree( spawnPos, playerPositions )
    for _, playerPos in ipairs( playerPositions ) do
        if playerPos:DistToSqr( spawnPos ) < CLOSENESS_LIMIT then
            return
        end
    end

    spawnTraceRequest.start = spawnPos
    spawnTraceRequest.endpos = spawnPos
    util.TraceHull( spawnTraceRequest )
    if spawnTraceResult.Hit then return false end

    return true
end

local function findFreeSpawnPoint( spawns, plys )
    local playerPositions = {}
    for _, ply in ipairs( plys ) do
        table.insert( playerPositions, ply:GetPos() )
    end

    local function find( spawnsCopy )
        for _ = 1, #spawnsCopy do
            local randomIndex = math.random( 1, #spawnsCopy )
            local spawn = spawnsCopy[randomIndex]
            local spawnPos = spawn.spawnPos
            local isFree = spawnIsFree( spawnPos, playerPositions )

            if isFree then
                -- this spawn is good!
                return spawn
            else
                -- remove this spawn!
                spawnsCopy[randomIndex] = spawnsCopy[#spawnsCopy]
                spawnsCopy[#spawnsCopy] = nil
            end
        end
    end

    -- Try given spawn list (which is limited by zone and pvp center)
    local spawn = find( table.Copy( spawns ) )
    if spawn then return spawn end

    -- Try all spawns with the same zoneID as the first spawn in the list (tldr remove the pvp center restriction)
    if #spawns ~= 0 then
        spawn = find( getSpawnsInZone( spawns, spawns[1].zoneID ) )
        if spawn then return spawn end
    end

    return customSpawnsForMap[math.random( 1, #customSpawnsForMap )] -- If all spawnpoints are full, just return a random spawn anywhere in the map. Rare case.
end

local function getPlyAvg( plys, fallbackPos )
    if not plys or not plys[1] then return fallbackPos or Vector() end

    local avgSum = Vector( 0, 0, 0 )

    for _, ply in ipairs( plys ) do
        avgSum = avgSum + ply:GetPos()
    end

    return avgSum / #plys
end

local function getDynamicPvpCenter( measurablePlayers )
    local playersAveragePos = getPlyAvg( measurablePlayers, DYNAMIC_CENTER_FALLBACK )

    local measurablePlysCount = #measurablePlayers

    -- add some randomness
    if DYNAMIC_CENTER_IMPERFECT then
        local offset = VectorRand() * 1000
        offset.z = 0
        playersAveragePos = playersAveragePos + offset
    end

    local closestSpawnToAverage = getNearestSpawn( playersAveragePos, customSpawnsForMap )
    local fauxPvpcenterPos = closestSpawnToAverage.spawnPos
    local zoneID = closestSpawnToAverage.zoneID
    -- use nearest spawnpoint as a sanity point
    local dynamicPvpCenter = {}
    dynamicPvpCenter.centerPos = fauxPvpcenterPos
    dynamicPvpCenter.zoneID = zoneID

    -- sorted spawns, for center's size stuff, this handles max size for us
    local spawnsSortedToClosest = spawnsSortedByDistTo( fauxPvpcenterPos, customSpawnsForMap, DYNAMIC_CENTER_MAXSIZE^2, zoneID )

    -- allow this to adapt to pvper count
    local minSpawns = DYNAMIC_CENTER_MINSPAWNS
    if DYNAMIC_CENTER_SPAWNCOUNTMATCHPVPERS then
        minSpawns = math.Clamp( DYNAMIC_CENTER_MINSPAWNS + measurablePlysCount, DYNAMIC_CENTER_MINSPAWNS, DYNAMIC_CENTER_MAXSPAWNS )
    end

    -- now determine the center's size
    local minSizeSqr = DYNAMIC_CENTER_MINSIZE^2
    local dynamicCenterSizeSqr = minSizeSqr
    local spawnCount = 0
    for _, spawnAndDist in ipairs( spawnsSortedToClosest ) do
        spawnCount = spawnCount + 1
        if spawnCount > DYNAMIC_CENTER_MAXSPAWNS then
            break
        end

        local currDistSqr = spawnAndDist.spawn.spawnPos:DistToSqr( fauxPvpcenterPos )

        if currDistSqr > dynamicCenterSizeSqr then
            dynamicCenterSizeSqr = currDistSqr
        end

        local bigEnough = currDistSqr > minSizeSqr
        local enoughInside = spawnCount >= minSpawns

        if bigEnough and enoughInside then
            break
        end
    end

    dynamicPvpCenter.radius = math.sqrt( dynamicCenterSizeSqr )
    dynamicPvpCenter.radiusSqr = dynamicCenterSizeSqr

    return dynamicPvpCenter
end

local function updateActivePvpCenter( measurablePlayers )
    activePvpCenter = getDynamicPvpCenter( measurablePlayers )

    CFCRandomSpawn.activePvpCenter = activePvpCenter

    CENTER_RADIUS = activePvpCenter.radius or DEFAULT_CENTER_RADIUS
    CENTER_RADIUS_SQR = activePvpCenter.radiusSqr or DEFAULT_CENTER_RADIUS_SQR

    -- Network to editors
    local editors = CFCRandomSpawn.EditingPlayers
    if not next( editors ) then return end

    -- Validate
    for i = #editors, 1, -1 do
        if not IsValid( editors[i] ) then
            table.remove( editors, i )
        end
    end

    if not next( editors ) then return end

    CFCRandomSpawn.syncActivePvpCenter()
end

function CFCRandomSpawn.getOptimalSpawnPos()
    local measurablePlayers = getMeasurablePlayers()
    local allLivingPlys = getLivingPlayers()

    if not CFCRandomSpawn.activePvpCenter then
        updateActivePvpCenter( measurablePlayers )
    end

    local spawnsInsideCenter = spawnsInsidePvpCenterCached( customSpawnsForMap )
    local randomFreeSpawn = findFreeSpawnPoint( spawnsInsideCenter, allLivingPlys )

    return randomFreeSpawn.spawnPos, randomFreeSpawn.spawnAngle
end

function CFCRandomSpawn.handlePlayerSpawn( ply )
    if not mapHasCustomSpawns then return end
    if not ( ply and IsValid( ply ) ) then return end

    -- TODO: make this a hook
    if IsValid( ply.LinkedSpawnPoint ) then return end

    local optimalSpawnPosition, optimalSpawnAngles = CFCRandomSpawn.getOptimalSpawnPos()

    ply:SetPos( optimalSpawnPosition )

    if optimalSpawnAngles then
        ply:SetEyeAngles( optimalSpawnAngles )
    end
end

hook.Add( "PlayerSpawn", "CFC_RandomSpawn_ChooseOptimalSpawnpoint", CFCRandomSpawn.handlePlayerSpawn )

timer.Create( "CFC_RandomSpawn_CalculateActivePvpCenter", CENTER_UPDATE_INTERVAL, 0, function()
    if not mapHasCustomSpawns then return end
    local measurablePlayers = getMeasurablePlayers()

    updateActivePvpCenter( measurablePlayers )
end )

concommand.Add( "cfc_spawneditor_pvpcenter_update_interval", function( ply, _, args )
    if IsValid( ply ) and not ply:IsAdmin() then return end
    if #args == 0 then return end

    timer.Adjust( "CFC_RandomSpawn_CalculateActivePvpCenter", tonumber( args[1] ), 0 )
end, nil, "Sets the update interval for pvp centers. Lasts until the next map change." )
