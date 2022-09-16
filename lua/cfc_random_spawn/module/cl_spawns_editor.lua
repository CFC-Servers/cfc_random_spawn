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

concommand.Add( "cfc_spawn_editor", function( ply )
    if not ply:IsAdmin() then return end
    spawnEditorEnabled = not spawnEditorEnabled
    if spawnEditorEnabled then
        requestSpawnPoints()
    end
end )

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
