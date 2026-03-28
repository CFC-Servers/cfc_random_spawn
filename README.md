# CFC Random Spawn
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
- `DEFAULT_CENTER_RADIUS` `(default 3000)` - Default cutoff range from the most popular pvp center, where players further away from this will be ignored. The system tries to place you closest to everyone else.
- `CLOSENESS_LIMIT` `(default 400)` - Will not choose spawnpoints that are within this many units of a valid player (i.e. a living pvper). 0 to disable.
- `SELECTION_SIZE` `(default 8)` - Max number of 'ideal' spawnpoints to select from randomly.
- `CENTER_UPDATE_INTERVAL` `(default 60)` - The gap (in seconds) between each center popularity update. If set to 0, will update on every respawn.
- `IGNORE_BUILDERS` `(default true)` - Should 'center popularity' and player position average not care about builders? Requires a PvP addon which has a function of the form `PLAYER:IsInPvp()`

Adding spawnpoints is done as follows:
- Create an entry to the `CUSTOM_SPAWNS` table for the map of your choosing, as follows:
  ```lua
  CFCRandomSpawn.Config.CUSTOM_SPAWNS["gm_bluehills_test3"] = {
    centerUpdateInterval = NUMBER,
    dynamicCenterStartingPos = VECTOR,
    zones = {
        { cornerA = VECTOR, cornerB = VECTOR },
        ...
    },
    spawnpoints = {
        { spawnPos = VECTOR, spawnAngle = ANGLE, pvp = BOOLEAN },
        ...
    }
  }
  ```
  Where 
  - `centerUpdateInterval` overrides `CENTER_UPDATE_INTERVAL` for this map.
  - `dynamicCenterStartingPos` defines the position to use for locating the dynamic pvp center when no active combat is happening. Best positioned at the 'natural spawn area' of the map, as this is guaranteed to happen on initial map load. Defaults to `Vector( 0, 0, 0 )`.
  - **zones**: defines boxes that separate spawns into groups. Except in rare cases, spawns will only be chosen if they are in the same zone as the currently active pvp center. Any spawns not contained by a zone will be added to a default group.
    - `cornerA` is the first corner of the zone.
    - `cornerB` is the second corner of the zone.
    - Lower-index zones will be checked first and will take priority if they overlap.
  - **spawnpoints**:
    - `spawnPos` is the foot position of the spawn.
    - `spawnAngle` is the view angle for the spawn.
    - `pvp` is the pvp status of the spawn (currently does nothing).

## Customizing spawnpoints

This addon provides a tool to help you create and remove spawnpoints.
To enable this tool run `cfc_spawneditor_toggle` in console.

Features:
- To add / remove spawns `cfc_spawneditor_spawnadd` / `cfc_spawneditor_spawndel`
- To mark / cancel / add / remove zones `cfc_spawneditor_zonea` and `cfc_spawneditor_zoneb` / `cfc_spawneditor_zonecancel` / `cfc_spawneditor_zoneadd` / `cfc_spawneditor_zonedel`
  - Zones will be previewed in magenta, then turn cyan when confirmed.
- To export the current map's spawnpoints to console use `cfc_spawneditor_export`, you can then paste this into sv_config.lua
- To change the update interval for pvp centers temporarily for debugging, use `cfc_spawneditor_pvpcenter_update_interval <interval>`

Visual appearance:
![image](https://user-images.githubusercontent.com/69946827/190715330-645c7701-953d-452e-aa52-9908e479eecf.png)

## Limitations
This addon is not finished, the following is required for completion:
- Currently `pvp` in the spawns table does nothing.
- The whole code could do with a bit of a cleanup, theres unused vars, params, old print tables, etc.
- Could make it possible for multiple pvp centers to be selected and then randomly chosen between (when under certain conditions) for maps with long and narrow or wide and sparse pvp areas that would benefit from having multiple centers grouped together.
