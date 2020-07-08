CFCRandomSpawn.Config.MAXIMUM_DISTANCE_FROM_PLAYERS = 500 -- The maximum distance it checks for players for when you spawnPos. You will automatically spawn where the least players are.
CFCRandomSpawn.Config.PVP_AGNOSTIC = true -- Should the addon ignore the pvp status of each spawn

CFCRandomSpawn.Config.CUSTOM_SPAWNS = {}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_bluehills_test3"] = {
    { spawnPos = Vector( 1104.6744384766,  131.18112182617,  64.03125 ) },
    { spawnPos = Vector( 385.55798339844,  157.09564208984,  64.03125 ) },
    { spawnPos = Vector( 1272.7860107422,  -485.29537963867, 264.03125 ) },
    { spawnPos = Vector( 1117.4444580078,  -1345.0144042969, 64.03125 ) },
    { spawnPos = Vector( 1458.7664794922,  -484.67016601563, 64.03125 ) },
    { spawnPos = Vector( 971.29565429688,  401.40603637695,  264.03125 ) },
    { spawnPos = Vector( 392.85052490234,  146.80117797852,  264.03125 ) },
    { spawnPos = Vector( -456.48602294922, -442.73083496094, 264.03125 ) },
    { spawnPos = Vector( 1148.5478515625,  90.367889404297,  456.03125 ) },
    { spawnPos = Vector( -214.91020202637, -623.013671875,   64.03125 ) },
    { spawnPos = Vector( -726.35272216797, -540.54400634766, 64.03125 ) },
    { spawnPos = Vector( -809.68939208984, 1255.5084228516,  464.03125 ) },
    { spawnPos = Vector( 425.38064575195,  1636.2911376953,  64.968605041504 ) },
    { spawnPos = Vector( -974.1875,        130.53991699219,  128.03125 ) },
    { spawnPos = Vector( -1357.5144042969, 1473.0662841797,  128.03125 ) },
    { spawnPos = Vector( -1000.3621826172, 1044.5682373047,  464.03125 ) }
}

-- CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_novenka"] = { --original
--     { spawnPos = Vector( 1374, 7406, -384 ) }, -- Angle( 0, -180, 0 )
--     { spawnPos = Vector( 1680, 7765, -384 ) }, -- Angle( 0, 90, 0 )
--     { spawnPos = Vector( 1912, 8614, -384 ) }, -- Angle( 0, 180, 0 )
--     { spawnPos = Vector( 1923, 9188, -384 ) }, -- Angle( 0, -180, 0 )
--     { spawnPos = Vector( 1887, 10007, -384 ) }, -- Angle( 0, 180, 0 )
--     { spawnPos = Vector( 2269, 10641, -384 ) }, -- Angle( 0, -180, 0 )
--     { spawnPos = Vector( 2933, 10829, -384 ) }, -- Angle( 0, 135, 0 )
--     { spawnPos = Vector( 5383, 11632, -384 ) }, -- Angle( 0, -45, 0 )
--     { spawnPos = Vector( 6108, 11502, -384 ) }, -- Angle( 0, -135, 0 )
--     { spawnPos = Vector( 5479, 10526, -384 ) }, -- Angle( 0, 45, 0 )
--     { spawnPos = Vector( 5657, 8442, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( 5694, 7804, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( 6397, 7841, -384 ) }, -- Angle( 0, 180, 0 )
--     { spawnPos = Vector( 5629, 7036, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( 6415, 6208, -384 ) }, -- Angle( 0, -180, 0 )
--     { spawnPos = Vector( 4546, 6546, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( 4397, 6035, -384 ) }, -- Angle( 0, -45, 0 )
--     { spawnPos = Vector( 4186, 5866, -384 ) }, -- Angle( 0, -45, 0 )
--     { spawnPos = Vector( 4030, 5333, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( 3218, 4862, -384 ) }, -- Angle( 0, -90, 0 )
--     { spawnPos = Vector( 3465, 4310, -384 ) }, -- Angle( 0, 45, 0 )
--     { spawnPos = Vector( 2748, 4293, -384 ) }, -- Angle( 0, 135, 0 )
--     { spawnPos = Vector( 2398, 5662, -384 ) }, -- Angle( 0, -90, 0 )
--     { spawnPos = Vector( 2135, 5672, -384 ) }, -- Angle( 0, -45, 0 )
--     { spawnPos = Vector( 2651, 5660, -384 ) }, -- Angle( 0, -135, 0 )
--     { spawnPos = Vector( 935, 5040, -384 ) }, -- Angle( 0, -135, 0 )
--     { spawnPos = Vector( 696, 6400, -384 ) }, -- Angle( 0, 180, 0 )
--     { spawnPos = Vector( 54, 6402, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( -499, 7236, -384 ) }, -- Angle( 0, 90, 0 )
--     { spawnPos = Vector( -1042, 7049, -384 ) }, -- Angle( 0, 135, 0 )
--     { spawnPos = Vector( -2026, 7021, -384 ) }, -- Angle( 0, 45, 0 )
--     { spawnPos = Vector( -2446, 7283, -384 ) }, -- Angle( 0, 45, 0 )
--     { spawnPos = Vector( -2580, 7039, -128 ) }, -- Angle( 0, -45, 0 )
--     { spawnPos = Vector( -2327, 6835, -128 ) }, -- Angle( 0, 135, 0 )
--     { spawnPos = Vector( -2636, 6797, -128 ) }, -- Angle( 0, 45, 0 )
--     { spawnPos = Vector( -2340, 8198, -384 ) }, -- Angle( 0, 0, 0 )
--     { spawnPos = Vector( -2435, 9145, -384 ) }, -- Angle( 0, 45, 0 )
--     { spawnPos = Vector( 3910, 7229, -184 ) }, -- Angle( 0, 135, 0 )
--     { spawnPos = Vector( 3872, 6256, -240 ) }, -- Angle( 0, 90, 0 )
--     { spawnPos = Vector( 2990, 8304, -264 ) } -- Angle( 0, 135, 0 )
-- }

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_novenka"] = { -- straw's idea
    { spawnPos = Vector( 6052, 11677, -383 ), spawnAngle = Ang( 0, 0, -135 ), pvp = true },
    { spawnPos = Vector( 6364, 10733, -383 ), spawnAngle = Ang( 0, 0, -90 ), pvp = true },
    { spawnPos = Vector( 9024, 10741, -383 ), spawnAngle = Ang( 0, 0, -148 ), pvp = true },
    { spawnPos = Vector( 5334, 11687, -383 ), spawnAngle = Ang( 0, 0, -45 ), pvp = true },
    { spawnPos = Vector( 4884, 11390, -383 ), spawnAngle = Ang( 0, 0, -45 ), pvp = true },
    { spawnPos = Vector( 4875, 10749, -383 ), spawnAngle = Ang( 0, 0, 42 ), pvp = true },
    { spawnPos = Vector( 6417, 5878, -383 ), spawnAngle = Ang( 0, 0, 135 ), pvp = true },
    { spawnPos = Vector( 8995, 6627, -383 ), spawnAngle = Ang( 0, 0, 135 ), pvp = true },
    { spawnPos = Vector( 8984, 7792, -383 ), spawnAngle = Ang( 0, 0, -180 ), pvp = true },
    { spawnPos = Vector( 8989, 9103, -383 ), spawnAngle = Ang( 0, 0, -135 ), pvp = true },
    { spawnPos = Vector( 9043, 9799, -383 ), spawnAngle = Ang( 0, 0, 124 ), pvp = true },
    { spawnPos = Vector( 7648, 10733, -383 ), spawnAngle = Ang( 0, 0, -90 ), pvp = true },
    { spawnPos = Vector( 8486, 5880, -383 ), spawnAngle = Ang( 0, 0, 155 ), pvp = true },
    { spawnPos = Vector( 7265, 5878, -383 ), spawnAngle = Ang( 0, 0, 45 ), pvp = true },
    { spawnPos = Vector( 5578, 6911, -383 ), spawnAngle = Ang( 0, 0, 45 ), pvp = true },
    { spawnPos = Vector( 5121, 8820, -127 ), spawnAngle = Ang( 0, 0, 90 ), pvp = true },
    { spawnPos = Vector( 4475, 8824, -127 ), spawnAngle = Ang( 0, 0, 59 ), pvp = true },
    { spawnPos = Vector( 4497, 9553, -127 ), spawnAngle = Ang( 0, 0, 8 ), pvp = true },
    { spawnPos = Vector( 5654, 8670, -383 ), spawnAngle = Ang( 0, 0, 0 ), pvp = true },
    { spawnPos = Vector( 5694, 7802, -383 ), spawnAngle = Ang( 0, 0, 0 ), pvp = true }
}
