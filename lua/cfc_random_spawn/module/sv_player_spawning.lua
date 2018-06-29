
hook.Add( "PlayerSpawn", "CFC_PlayerSpawning", function( ply, text, team )
    -- if ply in pvp
        for k, v in pairs( cfcRandomSpawn.config.PVP_SPAWN_LOCATIONS ) do
            if table.HasValue( v, game.GetMap() ) then
                local randomPosition = table.Random( v ) -- use this for reference
                local HDtNP = 0
                local bestPosition

                for k2, v2 in pairs( v ) do
                    if k2 == 0 and v2 == game.GetMap() then continue end
                    if k2 == 0 and v2 != game.GetMap() then return end

                    for k3, v3 in pairs( player.GetHumans() ) do
                        local pD = v3:GetPos():Distance( v2:GetPos() )
                        if pD > HDtNP then
                            HDtNP = pD
                            bestPosition = v2
                        end
                    end
                end

                -- by calling randomPosition it will work as it has been set up and I've decided not to remove it
                if randomPosition == game.GetMap() then randomPosition = table.Random( v ) repeat until randomPosition != game.GetMap() end

                timer.Simple( ply:Ping() / 500, function()
                    ply:SetPos( bestPosition )
                end)

                return
            end
        end
    -- end
end )
