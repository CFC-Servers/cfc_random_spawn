CFCRandomSpawn.Config.DEFAULT_CENTER_CUTOFF = 3000 -- Default cutoff range from the most popular pvp center, where players further away from this will be ignored. The system tries to place you closest to everyone else.
CFCRandomSpawn.Config.CLOSENESS_LIMIT = 400 -- Will not choose spawnpoints that are within this many units of a valid player (i.e. a living pvper). 0 to disable.
CFCRandomSpawn.Config.SELECTION_SIZE = 8 -- Max number of 'ideal' spawnpoints to select from randomly.
CFCRandomSpawn.Config.CENTER_UPDATE_INTERVAL = 60 -- The gap (in seconds) between each center popularity update. If set to 0, will update on every respawn.
CFCRandomSpawn.Config.IGNORE_BUILDERS = true -- Should 'center popularity' and player position average not care about builders? Requires a PvP addon which uses a function of the form PLAYER:isInPvp()

CFCRandomSpawn.Config.CUSTOM_SPAWNS = {}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_bluehills_test3"] = {
    centerCutoff = 2000,
    pvpCenters = {
        { centerPos = Vector( 292, -1.687, 265.938 ), overrideCutoff = nil }
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
    pvpCenters = {
        { centerPos = Vector( 7062.906, 8592.719, -246.125 ), overrideCutoff = nil }
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
    pvpCenters = {
        { centerPos = Vector( -2217.281, -133.062, 673.813 ), overrideCutoff = nil }
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
    pvpCenters = {
        { centerPos = Vector( -1983.062, -6900.937, -6423.969 ), overrideCutoff = nil },
        { centerPos = Vector( -4926.625, -5020.094, -6373.344 ), overrideCutoff = nil },
        { centerPos = Vector( -1963.531, -2343.344, -6392.75 ), overrideCutoff = nil }
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
    centerCutoff = nil,
    pvpCenters = {
        { centerPos = Vector( 1366.969, 1436.813, -382.781 ), overrideCutoff = 4000 },
        { centerPos = Vector( 8528.313, 9487.594, -457.969 ), overrideCutoff = 2500 },
        { centerPos = Vector( -1217.031, 11936.25, 898.188 ), overrideCutoff = 3000 },
        { centerPos = Vector( 13.125, -9500.844, -33.531 ), overrideCutoff = 4000 },
        { centerPos = Vector( 9218.438, -8647.375, -221.406 ), overrideCutoff = 6000 }
    },
    spawnpoints = {
        { spawnPos = Vector( 8457, 9881, 119 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 8284, 9776, -452 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 8851, 10123, -277 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 7706, 9785, -454 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9149, 9125, -301 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 7606, 9168, -453 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 9440, 10220, -448 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9370, 9232, -439 ), spawnAngle = Angle( 0, 107, 0 ), pvp = true },
        { spawnPos = Vector( 9950, 10156, -361 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 6829, 9326, -435 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 10228, 9289, -402 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 6357, 10316, -409 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 4116, 2738, -407 ), spawnAngle = Angle( 0, -54, 0 ), pvp = true },
        { spawnPos = Vector( 845, 13534, 850 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 326, 12243, 1309 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 191, 11989, 876 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( -79, 9772, 960 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 4775, 2082, -505 ), spawnAngle = Angle( 0, 160, 0 ), pvp = true },
        { spawnPos = Vector( -36, 11333, 960 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 347, 13345, 885 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 3670, 1824, -454 ), spawnAngle = Angle( 0, -35, 0 ), pvp = true },
        { spawnPos = Vector( -709, 13319, 885 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -1417, 9783, 960 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 4772, 627, -510 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 3099, 1416, 48 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 4249, 542, -469 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 3766, 551, -453 ), spawnAngle = Angle( 0, 115, 0 ), pvp = true },
        { spawnPos = Vector( 2609, 1058, -452 ), spawnAngle = Angle( 0, -69, 0 ), pvp = true },
        { spawnPos = Vector( -1765, 12855, 885 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2189, 10682, 904 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -1768, 13272, 885 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 1773, 1092, -456 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -2476, 11243, 904 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 2480, 269, -476 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -2843, 12620, 884 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 587, 1074, -427 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 1645, 60, -437 ), spawnAngle = Angle( 0, 96, 0 ), pvp = true },
        { spawnPos = Vector( -525, 1602, -261 ), spawnAngle = Angle( 0, -143, 0 ), pvp = true },
        { spawnPos = Vector( -1130, 2119, -223 ), spawnAngle = Angle( 0, -128, 0 ), pvp = true },
        { spawnPos = Vector( 830, 151, -399 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( -577, 421, -260 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -2543, 2708, -245 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( -1615, 1440, -216 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -2534, 1682, -205 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( 9525, -6914, -220 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 1283, -6093, -221 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 746, -6098, -221 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 1033, -6372, -4 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 10946, -7925, -220 ), spawnAngle = Angle( 0, -135, 0 ), pvp = true },
        { spawnPos = Vector( 344, -6244, -221 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 1296, -7112, -221 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 9475, -8570, -220 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 10487, -8543, -220 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 757, -7113, -221 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 347, -6933, -221 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( 14398, -7984, -604 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 14600, -7920, -604 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 12623, -8526, -220 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 14398, -8028, -604 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 14879, -7920, -604 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( 13265, -8470, -220 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 5105, -9505, 68 ), spawnAngle = Angle( 0, -45, 0 ), pvp = true },
        { spawnPos = Vector( 6101, -10821, 68 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 5971, -11340, 68 ), spawnAngle = Angle( 0, 135, 0 ), pvp = true },
        { spawnPos = Vector( 5277, -11628, 84 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 3198, -11393, 68 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -2987, -9297, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( 3359, -11999, 338 ), spawnAngle = Angle( 0, 45, 0 ), pvp = true },
        { spawnPos = Vector( -2994, -10030, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -2877, -10323, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true },
        { spawnPos = Vector( -9173, -1115, 10383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -9276, -1117, 10383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -9357, -1114, 10383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -9453, -1117, 10383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -9528, -1121, 10383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -9579, -1121, 10383 ), spawnAngle = Angle( 0, -90, 0 ), pvp = true },
        { spawnPos = Vector( -2126, -11218, 68 ), spawnAngle = Angle( 0, 90, 0 ), pvp = true },
        { spawnPos = Vector( 14271, -8264, -221 ), spawnAngle = Angle( 0, -180, 0 ), pvp = true },
        { spawnPos = Vector( -2978, -10919, 68 ), spawnAngle = Angle( 0, 0, 0 ), pvp = true }
    }
}

CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_freespace_13"] = {
    centerCutoff = 3000,
    pvpCenters = {
        { centerPos = Vector( -2374.25, -40.344, -14580.281 ), overrideCutoff = nil }
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
