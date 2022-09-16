local spawnEditorEnabled = false
local emptyAngle = Angle()
local playerMins = Vector( -16, -16, 0 )
local playerMaxs = Vector( 16, 16, 72 )
local eyeHeight = 55
local boxColor = Color( 0, 255, 0 )
local lineColor = Color( 0, 255, 0 )
local centerColor = Color( 255, 0, 0 )
local centerPointColor = Color( 255, 145, 0 )
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
        print( "Spawn editor is not enabled, enable it using cfc_spawn_editor_toggle." )
        return false
    end
    return true
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

            render.DrawWireframeSphere( centerPos, 5, 20, 20, centerColor, false )
            if centerCutoff > LocalPlayer():GetPos():Distance( centerPos ) then
                render.DrawLine( centerPos - Vector( 0, 0, centerCutoff ), centerPos + Vector( 0, 0, centerCutoff ), centerColor, true )
                render.DrawWireframeSphere( centerPos, centerCutoff, 75, 75, centerPointColor, true )
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
        requestSpawnPoints()
    end
end

concommand.Add( "cfc_spawn_editor_toggle", toggleEditor, _, "Toggles the spawn editor" )

local function addSpawn( ply )
    if not canRunCommand() then return end
    if not spawnTable.spawnpoints then spawnTable.spawnpoints = {} end

    table.insert( spawnTable.spawnpoints, { spawnPos = ply:GetPos(), spawnAngle = Angle( 0, math.Round( ply:EyeAngles().yaw ), 0 ) } )
end

concommand.Add( "cfc_spawn_editor_addspawn", addSpawn, _, "Adds a spawn point at your location" )

local function removeSpawn( ply )
    if not canRunCommand() then return end
    if not spawnTable.spawnpoints then return end

    local nearPos = ply:GetPos()

    for i, spawn in ipairs( spawnTable.spawnpoints ) do
        if 200 > nearPos:Distance( spawn.spawnPos ) then
            table.remove( spawnTable.spawnpoints, i )
            return
        end
    end
end

concommand.Add( "cfc_spawn_editor_delspawn", removeSpawn, _, "Removes the nearest spawn point" )

local function addPvpCenter( ply )
    if not canRunCommand() then return end
    if not spawnTable.pvpCenters then spawnTable.pvpCenters = {} end

    table.insert( spawnTable.pvpCenters, { centerPos = ply:GetPos() } )
end

concommand.Add( "cfc_spawn_editor_addpvpcenter", addPvpCenter, _, "Adds a pvp center at your location" )

local function removePvpCenter( ply )
    if not canRunCommand() then return end
    if not spawnTable.pvpCenters then spawnTable.pvpCenters = {} end

    local nearPos = ply:GetPos()

    for i, spawn in ipairs( spawnTable.pvpCenters ) do
        if 200 > nearPos:Distance( spawn.centerPos ) then
            table.remove( spawnTable.pvpCenters, i )
            return
        end
    end
end

concommand.Add( "cfc_spawn_editor_delpvpcenter", removePvpCenter, _, "Removes the nearest pvp center" )
