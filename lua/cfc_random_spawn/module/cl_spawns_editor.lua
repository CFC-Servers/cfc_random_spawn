local boxColor = Color( 0, 255, 0 )
local lineColor = Color( 0, 255, 0 )
local centerColor = Color( 255, 0, 0 )
local centerPointColor = Color( 255, 145, 0 )
local minDeletionRange = 5000
local suggestedSpawnCount = 25
local eyeHeight = 55
local playerMins = Vector( -16, -16, 0 )
local playerMaxs = Vector( 16, 16, 72 )

local spawnEditorEnabled = false
local emptyAngle = Angle()
local shownClearWarning = false
local shownSpawnCountWarning = false
local clearCode = tostring( math.random( 1000, 9999 ) )
local spawnTable = {}

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

hook.Add( "PostDrawTranslucentRenderables", "CFC_SpawnEditor_DrawSpawnPoints", function()
    if not spawnEditorEnabled then return end

    local centerCutoff = spawnTable.centerCutoff or 3000

    if spawnTable.spawnpoints then
        for _, spawn in ipairs( spawnTable.spawnpoints ) do
            local spawnPos = spawn.spawnPos
            local spawnAngle = spawn.spawnAngle
            render.DrawWireframeBox( spawnPos, spawnAngle or emptyAngle, playerMins, playerMaxs, boxColor, false )
            local linePos = spawnPos + Vector( 0, 0, eyeHeight )
            render.DrawLine( linePos , linePos + spawnAngle:Forward() * 50, lineColor, false )
        end
    end

    if spawnTable.pvpCenters then
        for _, center in ipairs( spawnTable.pvpCenters ) do
            local centerPos = center.centerPos

            if centerCutoff > LocalPlayer():GetPos():Distance( centerPos ) then
                render.DrawLine( centerPos - Vector( 0, 0, centerCutoff ), centerPos + Vector( 0, 0, centerCutoff ), centerColor, true )
                render.DrawWireframeSphere( centerPos, centerCutoff, 75, 75, centerPointColor, true )
                render.DrawWireframeSphere( centerPos, 5, 20, 20, centerColor, false )
            else
                render.DrawWireframeSphere( centerPos, 40, 20, 20, centerColor, false )
            end
        end
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
end

concommand.Add( "cfc_spawneditor_toggle", toggleEditor, _, "Toggles the spawn editor" )

local function addSpawn( ply )
    if not canRunCommand() then return end
    if not spawnTable.spawnpoints then spawnTable.spawnpoints = {} end

    table.insert( spawnTable.spawnpoints, { spawnPos = ply:GetPos(), spawnAngle = Angle( 0, math.Round( ply:EyeAngles().yaw ), 0 ) } )
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

    if istable( spawnTable.pvpCenters ) then
        mainString = mainString .. tab .. "pvpCenters = {\n"
        for _, center in ipairs( spawnTable.pvpCenters ) do
            mainString = mainString .. tab .. tab .. "{ "
            mainString = mainString .. string.format( "centerPos = Vector( %s, %s, %s )", center.centerPos.x, center.centerPos.y, center.centerPos.z )
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
