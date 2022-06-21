CFCRandomSpawn.Config.DEFAULT_CENTER_CUTOFF = 3000 -- Default cutoff range from the most popular pvp center, where players further away from this will be ignored. The system tries to place you closest to everyone else.
CFCRandomSpawn.Config.CLOSENESS_LIMIT = 400 -- Will not choose spawnpoints that are within this many units of a valid player (i.e. a living pvper). 0 to disable.
CFCRandomSpawn.Config.SELECTION_SIZE = 8 -- Max number of 'ideal' spawnpoints to select from randomly.
CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL = 60 -- The gap (in seconds) between each center popularity update. If set to 0, will update on every respawn.
CFCRandomSpawn.Config.IGNORE_BUILDERS = true -- Should 'center popularity' and player position average not care about builders? Requires a PvP addon which uses a function of the form PLAYER:isInPvp()

CFCRandomSpawn.Config.CUSTOM_SPAWNS = {}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_bluehills_test3"] = {
    centerCutoff = 2000,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( 292, -1, 265 ), overrideCutoff = nil }
    },
    spawnpoints = {
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
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_novenka"] = {
    centerCutoff = 4000,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( 7062, 8592, -246 ), overrideCutoff = nil }
    },
    spawnpoints = {
        { spawnPos = Vector( 6052, 11677, -383 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 6364, 10733, -383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9024, 10741, -383 ), spawnAngle = Angle( 0, -148, 0 ), pvp = true },
        { spawnPos = Vector( 5334, 11687, -383 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 4884, 11390, -383 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 4875, 10749, -383 ), spawnAngle = Angle( 0, 42, 0 ), pvp = true },
        { spawnPos = Vector( 6417, 5878, -383 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 8995, 6627, -383 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 8984, 7792, -383 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 8989, 9103, -383 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 9043, 9799, -383 ), spawnAngle = Angle( 0, 124, 0 ), pvp = true },
        { spawnPos = Vector( 7648, 10733, -383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 8486, 5880, -383 ), spawnAngle = Angle( 0, 155, 0 ), pvp = true },
        { spawnPos = Vector( 7265, 5878, -383 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 5578, 6911, -383 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 5121, 8820, -127 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 4475, 8824, -127 ), spawnAngle = Angle( 0, 59, 0 ), pvp = true },
        { spawnPos = Vector( 4497, 9553, -127 ), spawnAngle = Angle( 0, 8, 0 ), pvp = true },
        { spawnPos = Vector( 5654, 8670, -383 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 5694, 7802, -383 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_excess_construct_13"] = {
    centerCutoff = 2000,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( -2217, -133, 673 ), overrideCutoff = nil }
    },
    spawnpoints = {
        { spawnPos = Vector( -1483, -50, 673 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( -1168, -373, 673 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -2146, -822, 417 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2144, -1023, 721 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1983, -1177, 417 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -2354, -1025, 417 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( -1444, -1338, 409 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -1401, 798, 673 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -2818, -38, 673 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -2847, -717, 409 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1395, -1777, 673 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -2817, 580, 673 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -3213, -364, 673 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -1404, 1244, 673 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -3102, 866, 705 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2817, -2028, 673 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -3219, -1699, 673 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -1530, -2691, 673 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -3038, 1719, 705 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -2718, -2746, 673 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2816, 2270, 673 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_boreas"] = {
    centerCutoff = 3500,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( -1983, -6900, -6423 ), overrideCutoff = nil },
        { centerPos = Vector( -4926, -5020, -6373 ), overrideCutoff = nil },
        { centerPos = Vector( -1963, -2343, -6392 ), overrideCutoff = nil }
    },
    spawnpoints = {
        { spawnPos = Vector( -3212, -7423, -6398 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -4573, -7599, -6387 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -3713, -8180, -6054 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -5658, -5633, -6386 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -2693, -8561, -6099 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -5415, -5138, -6343 ), spawnAngle = Angle( 0, -20, 0 ), pvp = true },
        { spawnPos = Vector( -5397, -4600, -6349 ), spawnAngle = Angle( 0, 19, 0 ), pvp = true },
        { spawnPos = Vector( -6200, -5992, -6393 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -1904, -8868, -5896 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -1187, -8562, -6027 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -6372, -4870, -6039 ), spawnAngle = Angle( 0, -8, 0 ), pvp = true },
        { spawnPos = Vector( -5888, -4072, -6358 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -657, -8198, -6357 ), spawnAngle = Angle( 0, 132, 0 ), pvp = true },
        { spawnPos = Vector( 50, -7662, -6394 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -4014, -2066, -6389 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -756, -3021, -6347 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -3419, -1789, -6391 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -4690, -1758, -6378 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1083, -2322, -6393 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( 143, -3270, -6303 ), spawnAngle = Angle( 0, -92, 0 ), pvp = true },
        { spawnPos = Vector( -2627, -1465, -6397 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -5083, -1515, -6368 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 985, -3124, -6293 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_mobenix_v3_final"] = {
    centerCutoff = 4500,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( 3271, 2177, -382 ), overrideCutoff = 3000 },
        { centerPos = Vector( -742, 1255, -236 ), overrideCutoff = 2000 },
        { centerPos = Vector( 7655, 3721, -348 ), overrideCutoff = 4500 },
        { centerPos = Vector( 10493, 1187, -872 ), overrideCutoff = 4500 },
        { centerPos = Vector( 8192, 9471, -465 ), overrideCutoff = 4500 },
        { centerPos = Vector( 12027, -6395, -230 ), overrideCutoff = 4500 },
        { centerPos = Vector( 4650, -10795, -241 ), overrideCutoff = 4500 },
        { centerPos = Vector( -1084, 11651, 918 ), overrideCutoff = 4500 },
        { centerPos = Vector( -2679, -10945, 56 ), overrideCutoff = 4500 }
    },
    spawnpoints = {
        { spawnPos = Vector( 4772, 627, -510 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 4775, 2082, -505 ), spawnAngle = Angle( 0, 160, 0 ), pvp = true },
        { spawnPos = Vector( 4249, 542, -469 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 3766, 551, -453 ), spawnAngle = Angle( 0, 115, 0 ), pvp = true },
        { spawnPos = Vector( 3670, 1824, -454 ), spawnAngle = Angle( 0, -35, 0 ), pvp = true },
        { spawnPos = Vector( 4116, 2738, -407 ), spawnAngle = Angle( 0, -54, 0 ), pvp = true },
        { spawnPos = Vector( 6014, 2900, -453 ), spawnAngle = Angle( 0, 97, 0 ), pvp = true },
        { spawnPos = Vector( 3099, 1416, 48 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 5048, 3585, -537 ), spawnAngle = Angle( 0, -51, 0 ), pvp = true },
        { spawnPos = Vector( 2609, 1058, -452 ), spawnAngle = Angle( 0, -69, 0 ), pvp = true },
        { spawnPos = Vector( 2480, 269, -476 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 1773, 1092, -456 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 1645, 60, -437 ), spawnAngle = Angle( 0, 96, 0 ), pvp = true },
        { spawnPos = Vector( 7433, 4086, -345 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 8237, 4153, -327 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 830, 151, -399 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 8987, 3395, -300 ), spawnAngle = Angle( 0, 68, 0 ), pvp = true },
        { spawnPos = Vector( 587, 1074, -427 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 9711, 1453, -220 ), spawnAngle = Angle( 0, 25, 0 ), pvp = true },
        { spawnPos = Vector( 9691, 242, -220 ), spawnAngle = Angle( 0, -23, 0 ), pvp = true },
        { spawnPos = Vector( 9661, 2472, -230 ), spawnAngle = Angle( 0, 17, 0 ), pvp = true },
        { spawnPos = Vector( 9427, 3187, -245 ), spawnAngle = Angle( 0, 41, 0 ), pvp = true },
        { spawnPos = Vector( 9685, -759, -220 ), spawnAngle = Angle( 0, 21, 0 ), pvp = true },
        { spawnPos = Vector( 71, 1055, -332 ), spawnAngle = Angle( 0, -108, 0 ), pvp = true },
        { spawnPos = Vector( 8957, 4575, -273 ), spawnAngle = Angle( 0, -57, 0 ), pvp = true },
        { spawnPos = Vector( 10297, 1452, -220 ), spawnAngle = Angle( 0, 159, 0 ), pvp = true },
        { spawnPos = Vector( 10255, 234, -220 ), spawnAngle = Angle( 0, -166, 0 ), pvp = true },
        { spawnPos = Vector( -268, 1322, -293 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 9692, -1710, -220 ), spawnAngle = Angle( 0, -12, 0 ), pvp = true },
        { spawnPos = Vector( 10264, -721, -220 ), spawnAngle = Angle( 0, 155, 0 ), pvp = true },
        { spawnPos = Vector( 9327, -2545, -220 ), spawnAngle = Angle( 0, -23, 0 ), pvp = true },
        { spawnPos = Vector( -577, 421, -260 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 10493, 3151, -237 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 10276, -1712, -220 ), spawnAngle = Angle( 0, 177, 0 ), pvp = true },
        { spawnPos = Vector( 8869, -3624, -220 ), spawnAngle = Angle( 0, -9, 0 ), pvp = true },
        { spawnPos = Vector( 9809, -2767, -220 ), spawnAngle = Angle( 0, 159, 0 ), pvp = true },
        { spawnPos = Vector( -1215, 1118, -235 ), spawnAngle = Angle( 0, 47, 0 ), pvp = true },
        { spawnPos = Vector( -1203, 2152, -222 ), spawnAngle = Angle( 0, -121, 0 ), pvp = true },
        { spawnPos = Vector( 10183, 5205, -276 ), spawnAngle = Angle( 0, 154, 0 ), pvp = true },
        { spawnPos = Vector( 9473, -3625, -220 ), spawnAngle = Angle( 0, 164, 0 ), pvp = true },
        { spawnPos = Vector( 8843, -4284, -221 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 9502, -4271, -220 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -1954, 1578, -226 ), spawnAngle = Angle( 0, 80, 0 ), pvp = true },
        { spawnPos = Vector( -1991, 2516, -233 ), spawnAngle = Angle( 0, -128, 0 ), pvp = true },
        { spawnPos = Vector( -2534, 1682, -205 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 10433, 6784, -285 ), spawnAngle = Angle( 0, 161, 0 ), pvp = true },
        { spawnPos = Vector( 9879, 7321, -224 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2543, 2708, -245 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 6829, 9326, -435 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 10094, 7846, -257 ), spawnAngle = Angle( 0, -34, 0 ), pvp = true },
        { spawnPos = Vector( 7606, 9168, -453 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 11040, 7440, -233 ), spawnAngle = Angle( 0, 139, 0 ), pvp = true },
        { spawnPos = Vector( 9149, 9125, -301 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 7706, 9785, -454 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9370, 9232, -439 ), spawnAngle = Angle( 0, 107, 0 ), pvp = true },
        { spawnPos = Vector( 8284, 9776, -452 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 6357, 10316, -409 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 9525, -6914, -220 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 8457, 9881, 119 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 11049, 8622, -248 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 10225, 9285, -402 ), spawnAngle = Angle( -1, 71, 0 ), pvp = true },
        { spawnPos = Vector( 8851, 10123, -277 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 8841, -7935, -221 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 9440, 10220, -448 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 4043, -8791, 68 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 7104, -8744, 68 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -105, 9799, 960 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 9950, 10156, -361 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 2347, -8733, 68 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 10972, 9967, -327 ), spawnAngle = Angle( 0, -164, 0 ), pvp = true },
        { spawnPos = Vector( 8783, -8755, 68 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9475, -8570, -220 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 5105, -9505, 68 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 10946, -7925, -220 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 9542, -8742, 164 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -1391, 9819, 960 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 329, -8733, 68 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 10487, -8543, -220 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -36, 11333, 960 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 4087, -10261, 68 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 11363, -8538, -220 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 11960, -8549, -220 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 191, 11989, 876 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -1683, -8646, 68 ), spawnAngle = Angle( 0, -112, 0 ), pvp = true },
        { spawnPos = Vector( -2189, 10682, 904 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 6101, -10821, 68 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 326, 12243, 1309 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 7521, -10744, 68 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 3121, -10848, 68 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 12623, -8526, -220 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 13243, -8015, -220 ), spawnAngle = Angle( 0, -136, 0 ), pvp = true },
        { spawnPos = Vector( 6310, -11055, 355 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 1720, -10698, 68 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -376, -9961, 68 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 2861, -11051, 355 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 8761, -10789, 68 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 5971, -11340, 68 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 13265, -8470, -220 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -2476, 11243, 904 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 3198, -11393, 68 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -2992, -8646, 68 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 5277, -11628, 84 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 4210, -11616, 84 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 355, -10823, 68 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 14398, -7984, -604 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 14398, -8028, -604 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 347, 13345, 885 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 845, 13534, 850 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 14600, -7920, -604 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 14271, -8264, -221 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 14659, -7919, -604 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -2987, -9297, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 3359, -11999, 338 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 14831, -7920, -604 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 14879, -7920, -604 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -3268, 11545, 896 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -709, 13319, 885 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1765, 12855, 885 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2994, -10030, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -1082, -11205, 68 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -1768, 13272, 885 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -2843, 12620, 884 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -2877, -10323, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2126, -11218, 68 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2978, -10919, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_freespace_13"] = {
    centerCutoff = 3000,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( -2374, -40, -14580 ), overrideCutoff = nil }
    },
    spawnpoints = {
        { spawnPos = Vector( -1313, 25, -14566 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( -3040, 223, -14566 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -1200, 1, -14262 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( -3037, -223, -14566 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -1151, -161, -14566 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1323, 1122, -14566 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( -1023, -603, -14566 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -1322, -924, -14566 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -2654, 1623, -14566 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -3419, 956, -14566 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -1442, 1627, -14566 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -3416, -893, -14566 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -3423, 1538, -14566 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -2081, -1626, -14566 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2786, -1619, -14566 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -1753, -1781, -14566 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -4136, 922, -14566 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -1324, -1811, -14566 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -3411, -1532, -14566 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -4141, -987, -14566 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_trainconstruct2"] = {
    centerCutoff = 3000,
    centerUpdateInterval = nil,
    pvpCenters = {
        { centerPos = Vector( -4403, -276, -320 ), overrideCutoff = 3000 },
        { centerPos = Vector( -2532, 443, 16 ), overrideCutoff = 3000 },
        { centerPos = Vector( 217, 25, 8 ), overrideCutoff = 3000 },
        { centerPos = Vector( 2742, -2042, 16 ), overrideCutoff = 3000 },
        { centerPos = Vector( 7323, -1997, 16 ), overrideCutoff = 3000 },
        { centerPos = Vector( 10192, -1729, 16 ), overrideCutoff = 3000 }
    },
    spawnpoints = {
        { spawnPos = Vector( -6152, -153, 26 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -6156, 1370, 26 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -5792, 1568, 26 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -5441, -139, 26 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -5333, -308, -310 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -5402, -1242, -310 ), spawnAngle = Angle( 0, 34, 0 ), pvp = true },
        { spawnPos = Vector( -5334, -1342, -567 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -3813, 292, -310 ), spawnAngle = Angle( 0, -89, 0 ), pvp = true },
        { spawnPos = Vector( -3807, 1569, 26 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -3404, -780, -311 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -3056, 417, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -3110, -326, -310 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -2962, 428, -230 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2962, 836, -230 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2967, -196, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2966, -174, -230 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -3088, -751, -311 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2911, 1246, 26 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1973, -421, -542 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1801, -180, 26 ), spawnAngle = Angle( 0, 105, 0 ), pvp = true },
        { spawnPos = Vector( -937, 609, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -816, 599, 458 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -329, 1052, 10 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( 157, -321, 18 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 595, 117, 18 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 520, -1817, 26 ), spawnAngle = Angle( 0, -20, 0 ), pvp = true },
        { spawnPos = Vector( 1094, -1265, 10 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 1517, -833, 10 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 2203, -145, 22 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 2742, -2905, 26 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( 2856, -2714, 282 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 3045, -2613, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 4618, -1349, 26 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 5079, -2614, 26 ), spawnAngle = Angle( 0, 91, 0 ), pvp = true },
        { spawnPos = Vector( 5801, -1354, 26 ), spawnAngle = Angle( 0, -89, 0 ), pvp = true },
        { spawnPos = Vector( 6813, -1340, 26 ), spawnAngle = Angle( 0, -89, 0 ), pvp = true },
        { spawnPos = Vector( 7127, -2618, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 7813, -1342, 26 ), spawnAngle = Angle( 0, -89, 0 ), pvp = true },
        { spawnPos = Vector( 8850, -744, 26 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9231, -2598, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 10401, -1303, 10 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 10233, -2606, 26 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 10339, -2138, 26 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 10618, -2050, 26 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 11630, -1668, 26 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_obselisk"] = {
    centerCutoff = 3000,
    centerUpdateInterval = 30,
    pvpCenters = {
        { centerPos = Vector( -3981, -762, -1344 ), overrideCutoff = 3000 },
        { centerPos = Vector( -5558, 56, -1344 ), overrideCutoff = 3000 },
        { centerPos = Vector( -1693, -673, -1344 ), overrideCutoff = 3000 },
        { centerPos = Vector( 2904, -588, -2624 ), overrideCutoff = 3000 }
    },
    spawnpoints = {
        { spawnPos = Vector( -3680, -349, -1334 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -4513, -350, -1334 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -3935, -612, -1334 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -4254, -607, -1334 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -3940, -934, -1334 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -4256, -926, -1334 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -4514, -1187, -1334 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -4090, -1061, -598 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -5599, -927, -1334 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -5408, -1183, -1334 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -5404, 2010, -1334 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -4321, 2526, -1334 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -5661, 2271, -1334 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -5769, -1854, -1334 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -6687, -226, -1334 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -5627, 2524, -1334 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( -5666, -2237, -1334 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -6689, 1570, -1334 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -6366, -1850, -1334 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -6815, -1247, -1334 ), spawnAngle = Angle( 0, 46, 0 ), pvp = true },
        { spawnPos = Vector( -6625, 2019, -1334 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -6644, 2529, -1334 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -413, -1567, -1334 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 352, 156, -1334 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 354, 415, -1334 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 352, -161, -1334 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 350, -416, -1334 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( 349, -860, -1334 ), spawnAngle = Angle( 0, 180, 0 ), pvp = true },
        { spawnPos = Vector( 355, -1566, -1334 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 1186, -352, -2614 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 1277, 863, -2614 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 1183, -2015, -2422 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 1892, 1186, -2614 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 1951, -1184, -2614 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 1887, -2040, -2422 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 2866, 1167, -2614 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 2847, -1185, -2614 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 3044, 993, -2614 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true }
    }
}

