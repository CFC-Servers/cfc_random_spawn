
local customSpawnsForMap = cfcRandomSpawn.config.CUSTOM_SPAWNS[game.GetMap()]
local mapHasCustomSpawns = customSpawnsForMap ~= nil

hook.Remove( "PlayerSpawn", "CFC_PlayerSpawning" )

if mapHasCustomSpawns then
    cfcRandomSpawn.spawnPointRankings = cfcRandomSpawn.spawnPointRankings or {}

    local function getAlivePlayers()
        local alivePlayers = {}
        for _, ply in pairs( player.GetHumans() ) do
            if ( ply:Alive() ) then
                table.insert( alivePlayers, ply )
            end
        end

        return alivePlayers
    end

    local function getAveragePlayerDistanceFromCustomSpawn( spawn )
        local totalDistance = 0
        local alivePlayers = getAlivePlayers()
		
        for _, ply in pairs( alivePlayers ) do
            totalDistance = totalDistance + ply:GetPos():DistToSqr( spawn )
        end

        return totalDistance / #alivePlayers
    end

    function cfcRandomSpawn.getOptimalSpawnPosition()
		local randomSpawn = math.random(1,4)
        return cfcRandomSpawn.spawnPointRankings[randomSpawn]["spawn"]
    end

    function cfcRandomSpawn.updateSpawnPointRankings()
        local averagePlayerDistanceFromSpawns = {}

        for _, spawn in pairs( customSpawnsForMap ) do
            local averagePlayerDistance = getAveragePlayerDistanceFromCustomSpawn( spawn )

            local spawnDistanceData = {}
            spawnDistanceData["spawn"] = spawn
            spawnDistanceData["average-distance"] = averagePlayerDistance

            table.insert( averagePlayerDistanceFromSpawns, spawnDistanceData )
        end

        cfcRandomSpawn.spawnPointRankings = averagePlayerDistanceFromSpawns
        table.SortByMember( cfcRandomSpawn.spawnPointRankings, "average-distance", false )
    end

    timer.Create( "CFC_UpdateOptimalSpawnPosition", 0.5, 0, cfcRandomSpawn.updateSpawnPointRankings )

    function cfcRandomSpawn.handlePlayerSpawn( ply )
        if not (ply && IsValid( ply )) then return end
        if ply.LinkedSpawnPoint then return end
        local optimalSpawnPosition = cfcRandomSpawn.getOptimalSpawnPosition()

        ply:SetPos( optimalSpawnPosition )
        cfcRandomSpawn.updateSpawnPointRankings()
    end

    hook.Add( "PlayerSpawn", "CFC_PlayerSpawning", cfcRandomSpawn.handlePlayerSpawn )
end
