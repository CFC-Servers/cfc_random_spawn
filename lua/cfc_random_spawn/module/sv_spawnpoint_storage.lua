if not file.IsDir( CFCRandomSpawn.Config.DATA_FOLDER, "DATA" ) then
    file.CreateDir( CFCRandomSpawn.Config.DATA_FOLDER )
end

local files = file.Find( CFCRandomSpawn.Config.DATA_FOLDER .. "/*.json", "DATA" )

for _, v in ipairs( files ) do
    local text = file.Read( CFCRandomSpawn.Config.DATA_FOLDER .. "/" .. v )
    local tbl = util.JSONToTable( text )
    local mapname = string.Replace( v, ".json", "" )

    CFCRandomSpawn.Config.CUSTOM_SPAWNS[mapname] = tbl
end
