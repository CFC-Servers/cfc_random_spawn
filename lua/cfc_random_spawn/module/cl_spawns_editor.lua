local spawnColor = Color( 0, 255, 0 )
local spawnColorActiveCenter = Color( 200, 255, 0 )
local centerPointColor = Color( 255, 0, 0 )
local centerRangeColor = Color( 255, 145, 0 )
local centerActiveColor = Color( 255, 230, 0 )
local centerActiveRangeColor = Color( 255, 195, 0 )
local zoneUnconfirmedColor = Color( 255, 0, 255 )
local zoneConfirmedColor = Color( 0, 255, 255 )
local minDeletionRange = 5000
local suggestedSpawnCount = 25
local eyeHeight = 55
local playerMins = Vector( -16, -16, 0 )
local playerMaxs = Vector( 16, 16, 72 )

local spawnEditorEnabled = false
local emptyAngle = Angle()
local emptyVector = Vector()
local shownClearWarning = false
local shownSpawnCountWarning = false
local clearCode = tostring( math.random( 1000, 9999 ) )
local spawnTable = {}
local zoneCornerA = nil
local zoneCornerB = nil
local activeCenter = nil
local centerCutoffDefault = 3000


local function roundVector( vec, idp )
    return Vector( math.Round( vec[1], idp ), math.Round( vec[2], idp ), math.Round( vec[3], idp ) )
end

local function requestSpawnPoints()
    net.Start( "CFC_SpawnEditor_RequestSpawnPoints" )
    net.SendToServer()
end

net.Receive( "CFC_SpawnEditor_SendSpawnPoints", function()
    spawnTable = net.ReadTable()
end )

local function canRunCommand()
    local ply = LocalPlayer()
    if not ply:IsAdmin() then
        print( "Sorry only admins can run this command." )
        return false
    end

    if not spawnEditorEnabled then
        print( "Spawn editor is not enabled, enable it using cfc_spawneditor_toggle." )
        return false
    end

    return true
end

local function sendConfigChangesToServer()
    net.Start( "CFC_SpawnEditor_UpdateSpawnPoints" )
    net.WriteTable( spawnTable )
    net.SendToServer()
end

local function drawPvPCenter( center, pointColor, rangeColor, radius )
    local pos = center.centerPos
    local cutoff = spawnTable.centerCutoff or centerCutoffDefault

    if cutoff > LocalPlayer():GetPos():Distance( pos ) then
        render.DrawLine( pos - Vector( 0, 0, cutoff ), pos + Vector( 0, 0, cutoff ), pointColor, true )
        render.DrawWireframeSphere( pos, cutoff, 75, 75, rangeColor, true )
        render.DrawWireframeSphere( pos, radius, 20, 20, pointColor, false )
    else
        render.DrawWireframeSphere( pos, radius, 10, 20, pointColor, false )
    end
end

hook.Add( "PostDrawTranslucentRenderables", "CFC_SpawnEditor_DrawSpawnPoints", function( _, sky, sky3d )
    if not spawnEditorEnabled then return end
    if sky or sky3d then return end

    if spawnTable.spawnpoints then
        local activeCenterPos
        local activeCenterCutoff
        local activeCenterZoneCornerA
        local activeCenterZoneCornerB

        -- Cace active center stuff
        if activeCenter then
            activeCenterPos = activeCenter.centerPos
            activeCenterCutoff = activeCenter.centerCutoff or centerCutoffDefault

            if spawnTable.zones then
                local zone = spawnTable.zones[activeCenter.zoneID]

                if zone then
                    activeCenterZoneCornerA = zone.cornerA
                    activeCenterZoneCornerB = zone.cornerB
                end
            end
        end

        -- Draw spawns
        for _, spawn in ipairs( spawnTable.spawnpoints ) do
            local spawnPos = spawn.spawnPos
            local spawnAngle = spawn.spawnAngle
            local color = spawnColor

            if activeCenterPos and spawnPos:Distance( activeCenterPos ) <= activeCenterCutoff then
                local isInZone = activeCenterZoneCornerA == nil or spawnPos:WithinAABox( activeCenterZoneCornerA, activeCenterZoneCornerB )

                if isInZone then
                    color = spawnColorActiveCenter
                end
            end

            render.DrawWireframeBox( spawnPos, spawnAngle or emptyAngle, playerMins, playerMaxs, color, false )

            local linePos = spawnPos + Vector( 0, 0, eyeHeight )
            render.DrawLine( linePos, linePos + spawnAngle:Forward() * 50, color, false )
        end
    end

    if spawnTable.pvpCenters then
        for _, center in ipairs( spawnTable.pvpCenters ) do
            drawPvPCenter( center, centerPointColor, centerRangeColor, 40 )
        end
    end

    if spawnTable.zones then
        for _, zone in ipairs( spawnTable.zones ) do
            render.DrawWireframeBox( emptyVector, emptyAngle, zone.cornerA, zone.cornerB, zoneConfirmedColor, false )
        end
    end

    if zoneCornerA and zoneCornerB then
        render.DrawWireframeBox( emptyVector, emptyAngle, zoneCornerA, zoneCornerB, zoneUnconfirmedColor, false )
    end

    if activeCenter then
        drawPvPCenter( activeCenter, centerActiveColor, centerActiveRangeColor, 50 )
    end
end )

local function toggleEditor( ply )
    if not ply:IsAdmin() then
        print( "Sorry only admins can run this command." )
        return
    end

    spawnEditorEnabled = not spawnEditorEnabled
    if spawnEditorEnabled then
        print( "Editor turned on!" )
        requestSpawnPoints()
    else
        print( "Editor turned off!" )
    end

    net.Start( "CFC_SpawnEditor_SetEditing" )
    net.WriteBool( spawnEditorEnabled )
    net.SendToServer()
end

concommand.Add( "cfc_spawneditor_toggle", toggleEditor, _, "Toggles the spawn editor" )

local function addSpawn( ply )
    if not canRunCommand() then return end
    if not spawnTable.spawnpoints then spawnTable.spawnpoints = {} end

    local pos = ply:GetPos()
    pos[3] = math.ceil( pos[3] ) -- Round z upwards to prevent clipping into the floor
    pos = roundVector( pos ) -- Round everything else normally

    local eyeAngles = ply:EyeAngles():SnapTo( "y", 11.25 ) -- 11.25 * 32 == 360

    table.insert( spawnTable.spawnpoints, { spawnPos = pos, spawnAngle = Angle( 0, math.Round( eyeAngles.yaw ), 0 ) } )
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_spawnadd", addSpawn, _, "Adds a spawn point at your location" )

local function removeSpawn( ply )
    if not canRunCommand() then return end
    if not spawnTable.spawnpoints then return end

    local nearPos = ply:GetPos()
    local spawnpoints = spawnTable.spawnpoints

    table.sort( spawnpoints, function( a, b )
        return nearPos:DistToSqr( a.spawnPos ) < nearPos:DistToSqr( b.spawnPos )
    end )

    if spawnTable.spawnpoints[1].spawnPos:DistToSqr( ply:GetPos() ) > minDeletionRange then
        print( "You are too far away from the nearest spawn point, please move closer to it." )
        return
    end

    table.remove( spawnTable.spawnpoints, 1 )
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_spawndel", removeSpawn, _, "Removes the nearest spawn point" )

local function addPvpCenter( ply )
    if not canRunCommand() then return end
    if not spawnTable.pvpCenters then spawnTable.pvpCenters = {} end

    table.insert( spawnTable.pvpCenters, { centerPos = ply:GetPos() } )
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_centeradd", addPvpCenter, _, "Adds a pvp center at your location" )

local function removePvpCenter( ply )
    if not canRunCommand() then return end
    if not spawnTable.pvpCenters then spawnTable.pvpCenters = {} end

    local nearPos = ply:GetPos()
    local pvpCenters = spawnTable.pvpCenters

    table.sort( pvpCenters, function( a, b )
        return nearPos:DistToSqr( a.centerPos ) < nearPos:DistToSqr( b.centerPos )
    end )

    if spawnTable.pvpCenters[1].centerPos:DistToSqr( ply:GetPos() ) > minDeletionRange then
        print( "You are too far away from the nearest pvp center, please move closer to it." )
        return
    end

    table.remove( spawnTable.pvpCenters, 1 )
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_centerdel", removePvpCenter, _, "Removes the nearest pvp center" )

local function setCenterCutoff( _, _, args )
    if not canRunCommand() then return end
    if not spawnTable.pvpCenters then spawnTable.pvpCenters = {} end

    local cutoff = tonumber( args[1] )
    if not cutoff then
        print( "Please provide a number for the cutoff." )
        return
    end

    if spawnTable.centerCutoff then
        print( "Overwriting old cutoff of " .. spawnTable.centerCutoff )
    end
    spawnTable.centerCutoff = cutoff
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_cutoff", setCenterCutoff, _, "Sets the cutoff for pvp centers, requires a number." )

local function markZoneA( ply, _, _, argsStr )
    if not canRunCommand() then return end

    zoneCornerA = roundVector( argsStr == "eyes" and ply:EyePos() or ply:GetPos() )
end

concommand.Add( "cfc_spawneditor_zonea", markZoneA, _, "Marks corner A for a pvp spawn zone. Pass an argument of 'eyes' to position at your eyes instead of your feet." )

local function markZoneB( ply, _, _, argsStr )
    if not canRunCommand() then return end

    zoneCornerB = roundVector( argsStr == "eyes" and ply:EyePos() or ply:GetPos() )
end

concommand.Add( "cfc_spawneditor_zoneb", markZoneB, _, "Marks corner B for a pvp spawn zone. Pass an argument of 'eyes' to position at your eyes instead of your feet." )

local function cancelZoneMarking()
    if not canRunCommand() then return end

    zoneCornerA = nil
    zoneCornerB = nil
end

concommand.Add( "cfc_spawneditor_zonecancel", cancelZoneMarking, _, "Cancels pvp spawn zone marking." )

local function addZone()
    if not canRunCommand() then return end
    if not spawnTable.zones then spawnTable.zones = {} end

    if not zoneCornerA then
        print( "Missing corner A" )
        return
    end

    if not zoneCornerB then
        print( "Missing corner B" )
        return
    end

    table.insert( spawnTable.zones, { cornerA = zoneCornerA, cornerB = zoneCornerB } )
    zoneCornerA = nil
    zoneCornerB = nil
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_zoneadd", addZone, _, "Marks corner A for a pvp spawn zone" )

local volumeShrinkMult = 1 / 100
local function removeZone( ply, _, _, argsStr )
    if not canRunCommand() then return end
    if not spawnTable.zones then spawnTable.zones = {} end

    local pos = argsStr == "eyes" and ply:EyePos() or ply:GetPos()
    local bestZoneID = nil
    local bestVolume = math.huge
    local zones = spawnTable.zones

    for zoneID, zone in ipairs( zones ) do
        local a = zone.cornerA
        local b = zone.cornerB

        if pos:WithinAABox( a, b ) then
            -- Shrink the difference before getting volume so the result doesn't blow out of float range.
            local volumeApprox = math.abs(
                ( ( a[1] - b[1] ) * volumeShrinkMult ) *
                ( ( a[2] - b[2] ) * volumeShrinkMult ) *
                ( ( a[3] - b[3] ) * volumeShrinkMult )
            )

            if volumeApprox < bestVolume then
                bestZoneID = zoneID
                bestVolume = volumeApprox
            end
        end
    end

    if not bestZoneID then
        print( "You are not inside a pvp spawn zone." )
        return
    end

    table.remove( zones, bestZoneID )
    sendConfigChangesToServer()
end

concommand.Add( "cfc_spawneditor_zonedel", removeZone, _, "Removes the smallest pvp spawn zone you are inside. Pass an argument of 'eyes' to position at your eyes instead of your feet." )

local function printSpawnTable()
    if not canRunCommand() then return end

    local spawnpointCount = spawnTable.spawnpoints and #spawnTable.spawnpoints or 0
    if not shownSpawnCountWarning and suggestedSpawnCount > spawnpointCount then
        print( "You have " .. spawnpointCount .. " spawns, it is recommended to have at least " .. suggestedSpawnCount .. " spawns! run again to ignore message." )
        shownSpawnCountWarning = true
        return
    end

    if not shownClearWarning then
        print( "Make sure to first run clean in console so you can copy paste everything easily, run again to run command." )
        shownClearWarning = true
        return
    end

    local tab = "   "

    local mainString = string.format( [[CFCRandomSpawn.Config.CUSTOM_SPAWNS["%s"] = {%s]], game.GetMap(), "\n" )

    if spawnTable.centerCutoff then
        mainString = mainString .. tab .. "centerCutoff = " .. spawnTable.centerCutoff .. ",\n"
    end

    if spawnTable.centerUpdateInterval then
        mainString = mainString .. tab .. "centerUpdateInterval = " .. spawnTable.centerUpdateInterval .. ",\n"
    end

    if spawnTable.dynamicCenterStartingPos then
        local vec = spawnTable.dynamicCenterStartingPos
        mainString = mainString .. tab .. string.format( "dynamicCenterStartingPos = Vector( %s, %s, %s ),\n", vec.x, vec.y, vec.z )
    end

    if istable( spawnTable.pvpCenters ) then
        mainString = mainString .. tab .. "pvpCenters = {\n"
        for _, center in ipairs( spawnTable.pvpCenters ) do
            mainString = mainString .. tab .. tab .. "{ "
            mainString = mainString .. string.format( "centerPos = Vector( %s, %s, %s )", center.centerPos.x, center.centerPos.y, center.centerPos.z )
            mainString = mainString .. " },\n"
        end
        mainString = mainString .. tab .. "},\n"
    end

    if istable( spawnTable.zones ) then
        mainString = mainString .. tab .. "zones = {\n"
        for _, zone in ipairs( spawnTable.zones ) do
            mainString = mainString .. tab .. tab .. "{ "
            mainString = mainString .. string.format( "cornerA = Vector( %s, %s, %s ), ", zone.cornerA.x, zone.cornerA.y, zone.cornerA.z )
            mainString = mainString .. string.format( "cornerB = Vector( %s, %s, %s ) ", zone.cornerB.x, zone.cornerB.y, zone.cornerB.z )
            mainString = mainString .. " },\n"
        end
        mainString = mainString .. tab .. "},\n"
    end

    if istable( spawnTable.spawnpoints ) then
        mainString = mainString .. tab .. "spawnpoints = {\n"
        for _, spawn in ipairs( spawnTable.spawnpoints ) do
            mainString = mainString .. tab .. tab .. "{ "
            mainString = mainString .. string.format( "spawnPos = Vector( %s, %s, %s ),", spawn.spawnPos.x, spawn.spawnPos.y, spawn.spawnPos.z )
            mainString = mainString .. string.format( " spawnAngle = Angle( %s, %s, %s )", spawn.spawnAngle.p, spawn.spawnAngle.y, spawn.spawnAngle.r )
            mainString = mainString .. " },\n"
        end
        mainString = mainString .. tab .. "},\n"
    end

    mainString = mainString .. "}"

    local lines = string.Explode( "\n", mainString )

    for _, line in ipairs( lines ) do
        print( line )
    end
end

concommand.Add( "cfc_spawneditor_export", printSpawnTable, _, "Prints the spawn table to the console for easy exporting." )

local function clearAll( _, _, args )
    if not canRunCommand() then return end

    if clearCode ~= args[1] then
        print( "Please provide the correct code to clear all spawns. The code is: " .. clearCode )
        return
    end

    clearCode = tostring( math.random( 1000, 9999 ) )

    spawnTable = {}
    sendConfigChangesToServer()

    print( "Cleared all spawns!" )
end

concommand.Add( "cfc_spawneditor_clearall", clearAll, _, "Clears all spawn points and pvp centers. Dangerous." )


net.Receive( "CFC_SpawnEditor_ActiveCenter", function()
    activeCenter = {
        centerPos = net.ReadVector(),
        centerCutoff = net.ReadFloat(),
        zoneID = net.ReadUInt( 10 ),
    }
end )
