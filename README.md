# [In Dev] CFC Random Spawn
CFC's Implementation of random spawn points for use with maps that have spawns which are less-than-ideal for PvP

## Overview
Not all maps have desirable spawns, and gmod doesn't easily allow you to modify them. Also, we cannot rely on random chance to not give poor spawns from time to time. For example, in a PvP setting, many players have started fighting in a specific place, spawning in the middle of this before having chance to get weapons/a better position can lead to being spawnkilled, and an unpleasent experience.  
This project aims to be the solution to these problems, providing simple spawnpoint configuration, and automatic spawnpoint ranking based on player proximity.  
It also allows map specific spawns, allowing you to change map as you would normally, and the spawn points will automatically change to whatever you have configured.  

## Installation
Clone or download this repository into your `garrysmod/addons` folder and restart your server/game.

## Usage Instructions
The config for this addon is located in the `cfc_random_spawn/lua/cfc_random_spawn/sv_config.lua` file.  
Here you will find 2 config constants, and the spawn points table structure. The constants are as follows:
- `MAXIMUM_DISTANCE_FROM_PLAYERS` - UNKNOWN
- `PVP_AGNOSTIC` - UNKNOWN

Adding spawnpoints is done as follows:
- Create an entry to the `CUSTOM_SPAWNS` table for the map of your choosing, as follows:
  `CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_bluehills_test3"] = { ...`
- Fill this table with spawn point entries, with the following format:
  `{ spawnPos = Vector(), spawnAngle = Angle(), pvp = bool },`
  Where 
  - `spawnPos` is the foot position of the spawn
  - `spawnAngle` is the view angle for the spawn (currently does nothing)
  - `pvp` is the pvp status of that spawn (currently does nothing)

## Limitations
This addon is not finished, the following is required for completion:
- Currently neither of the constants in config do anything, same with the `spawnAngle` and `pvp` in the spawns table.
- The whole code could do with a bit of a cleanup, theres unused vars, params, old print tables, etc.
