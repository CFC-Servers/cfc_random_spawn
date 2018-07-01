local customSpawnsForMap = cfcRandomSpawn.config.CUSTOM_SPAWNS[game.GetMap()]
local mapHasCustomSpawns = customSpawnsForMap ~= nil

hook.Remove( "PlayerSpawn", "CFC_PlayerSpawning" )

if mapHasCustomSpawns then
    cfcRandomSpawn.spawnPointRankings = cfcRandomSpawn.spawnPointRankings or {}

    local function getMeasurablePlayers()
        local measurablePlayers = {}
        for _, ply in pairs( player.GetHumans() ) do
            if ( ply:Alive() ) then
                table.insert( measurablePlayers, ply )
            end
        end

        return measurablePlayers
    end

    -- This is operating on a model of spawn points and players as electrons putting a force on each other
    -- The best spawn point is the spawn point under the smallest sum of forces then. This is why we use physics terms here
    local function getPlayerForceFromCustomSpawn( spawn )
        local totalDistanceSquared = 0
        local measurablePlayers = getMeasurablePlayers()
		
        for _, ply in pairs( measurablePlayers ) do
	    local plyDistanceSqr = ( ply:GetPos():DistToSqr( spawn ) )
	    if plyDistanceSqr < 30*30 then plyDistanceSqr = 1 end
            totalDistanceSquared = totalDistanceSquared + 1/( plyDistanceSqr )
	end
        return totalDistanceSquared 
    end

    function cfcRandomSpawn.getOptimalSpawnPosition()
		local randomSpawn = math.random(1,4)
        return cfcRandomSpawn.spawnPointRankings[randomSpawn]["spawn"]
    end

    function cfcRandomSpawn.updateSpawnPointRankings()
        local playerIDSFromSpawns = {}

        for _, spawn in pairs( customSpawnsForMap ) do
            local playerNetForce = getPlayerForceFromCustomSpawn( spawn )

            local spawnDistanceData = {}
            spawnDistanceData["spawn"] = spawn

            spawnDistanceData["inverse-distance-squared"] = playerNetForce
            table.insert( playerIDSFromSpawn, spawnDistanceData ) --ISD == Inverse Distance Squared
        end


        cfcRandomSpawn.spawnPointRankings = playerIDSFromSpawn
        table.SortByMember( cfcRandomSpawn.spawnPointRankings, "inverse-distance-squared", true )
    end

    --timer.Create( "CFC_UpdateOptimalSpawnPosition", 0.5, 0, cfcRandomSpawn.updateSpawnPointRankings )

    function cfcRandomSpawn.handlePlayerSpawn( ply )
        if not (ply && IsValid( ply )) then return end
        if ply.LinkedSpawnPoint then return end
		
		cfcRandomSpawn.updateSpawnPointRankings()
        local optimalSpawnPosition = cfcRandomSpawn.getOptimalSpawnPosition()

        ply:SetPos( optimalSpawnPosition )
    end

    hook.Add( "PlayerSpawn", "CFC_PlayerSpawning", cfcRandomSpawn.handlePlayerSpawn )
end
