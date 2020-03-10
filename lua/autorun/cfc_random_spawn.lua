
CFCRandomSpawn = CFCRandomSpawn or {
    config = {},

    IDENTIFIER = "cfcRandomSpawn",
    NICE_NAME = "cfcRandomSpawn"
}

local version = 1

-- A valid instance already exists
if CFCRandomSpawnInit and CFCRandomSpawnInit.VERSION >= version then return end

CFCRandomSpawnInit = {
    VERSION = version,

    STATE_SERVER = 0,
    STATE_CLIENT = 1,
    STATE_SHARED = 2
}

local function isSharedFile( filename, state )
    return state == CFCRandomSpawnInit.STATE_SHARED or filename:find( "sh_" )
end

local function isServerFile( filename, state )
    return state == CFCRandomSpawnInit.STATE_SERVER or ( SERVER and filename:find( "sv_" ) )
end

local function isClientFile( filename, state )
    return state == CFCRandomSpawnInit.STATE_CLIENT or filename:find( "cl_" )
end

function CFCRandomSpawnInit.includeFile( filename, state )
    if isSharedFile( filename, state ) then
        if SERVER then AddCSLuaFile( filename ) end
        include( filename )
    elseif isServerFile( filename, state ) then
        include( filename )
    elseif isClientFile( filename, state ) then
        if SERVER then AddCSLuaFile( filename ) else include( filename ) end
    end
end

function CFCRandomSpawnInit.includeFolder( currentFolder, ignoreFilesInFolder, ignoreFoldersInFolder )
    if file.Exists( currentFolder .. "sh_CFCRandomSpawnInit.lua", "LUA" ) then
        return CFCRandomSpawnInit.includeFile( currentFolder .. "sh_CFCRandomSpawnInit.lua" )
    end

    local files, folders = file.Find( currentFolder .. " * ", "LUA" )

    if not ignoreFilesInFolder then
        for _, filename in ipairs( files ) do
            CFCRandomSpawnInit.includeFile( currentFolder .. filename )
        end
    end

    if not ignoreFoldersInFolder then
        for _, folder in ipairs( folders ) do
            CFCRandomSpawnInit.includeFolder( currentFolder .. folder .. "/" )
        end
    end
end

-- Do not adjust the load order. You must first load the libraries, then module, and then languages.
CFCRandomSpawnInit.includeFolder( "cfc_random_spawn/", false, true )
CFCRandomSpawnInit.includeFolder( "cfc_random_spawn/module/" )
