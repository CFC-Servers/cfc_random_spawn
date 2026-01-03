CFCRandomSpawn.Config.DEFAULT_CENTER_CUTOFF = 3000 -- Default cutoff range from the most popular pvp center, where players further away from this will be ignored. The system tries to place you closest to everyone else.
CFCRandomSpawn.Config.CLOSENESS_LIMIT = 400 -- Will not choose spawnpoints that are within this many units of a valid player (i.e. a living pvper).
CFCRandomSpawn.Config.SELECTION_SIZE = 16 -- Max number of 'ideal' spawnpoints to select from randomly.
CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL = 120 -- The gap (in seconds) between each center popularity update. If set to 0, will update on every respawn.
CFCRandomSpawn.Config.IGNORE_BUILDERS = true -- Should 'center popularity' and player position average not care about builders? Requires a PvP addon which uses a function of the form PLAYER:IsInPvp()

CFCRandomSpawn.Config.CUSTOM_SPAWNS = {}

function CFCRandomSpawn.loadConfig()
    local configPath = "cfc_random_spawn/configs/" .. game.GetMap() .. ".lua"
    local exists = file.Exists( configPath, "LUA" )
    if exists then
        print( "[CFC Random Spawn] Loading config: " .. configPath )
        include( configPath )
    else
        print( "[CFC Random Spawn] No config found for map: " .. game.GetMap() )
    end
end
