local skynet = require "skynet"
local con = require "connect"
local err = require "error"
local const = require "const"

--WorldAoiManager
local WorldAoiManager = {}
WorldAoiManager.length = 0
WorldAoiManager.width = 0
WorldAoiManager.lenMax = 0
WorldAoiManager.widMax = 0
WorldAoiManager.tiles = {}

function WorldAoiManager.init(length, width)
    WorldAoiManager.length = length
    WorldAoiManager.width = width
    WorldAoiManager.lenMax = math.ceil(WorldAoiManager.length/const.TileLen)
    WorldAoiManager.widMax = math.ceil(WorldAoiManager.width/const.TileLen)

    for i = 1, WorldAoiManager.lenMax do
        for j = 1, WorldAoiManager.widMax do
            local tile = {}
            tile.watchers = {}
            tile.objs = {}
            if not WorldAoiManager.tiles[i] then
                WorldAoiManager.tiles[i] = {}
            end
            WorldAoiManager.tiles[i][j] = tile
        end
    end


    local jps = require "jps"
    local j = jps.new({     -- create 2D grid map
        w = 20,             -- width of map
        h = 20,             -- height of map
        obstacle = {        -- obstacle in map
            {1,1},{1,2},{1,3},{1,4},{1,5},{1,6}
        },
    })

    print("---------------------------:", j:check_block(1, 1))
    print("---------------------------:", j:check_block(1, 3))
    print("---------------------------:", j:check_block(1, 6))

    
    print("---------------------------:", j:check_block(2, 1))
    print("---------------------------:", j:check_block(2, 3))
    print("---------------------------:", j:check_block(2, 6))

    j:set_start(0,0)        -- set start point
    j:set_end(10,10)        -- set end point
    j:add_block(1, 1)       -- set one obstacle point
    j:add_blockset({        -- batch set obstacle points
        {1,0},{1,19},{5,3},{6,3},{6,4},{6,5},{5,5},
        {9,9},{10,9},{11,9},{12,9},{13,9},
        {9,10},{9,11},{9,12},{9,13},{9,14},
        {14,9},{14,10},{14,11},{14,12},{14,13},{14,14},
        {9,14},{10,14},{11,14},{12,14},{13,14},
    })
    j:clear_block(1,1)      -- clear one obstacle point
    j:clear_allblock()      -- clear all obstacle
    j:mark_connected()      -- mark map connected for speed up search path to unreachable point
    j:dump_connected()      -- print connected mark of map
    --[[
        search for path from start to end, return the jump points list in table
        if make with CFLAG="-D__CONNER_SOLVE__", it will avoid across conner diagonal grid
    ]]
    local path = j:find_path()
    j:dump()                -- print map, if make with CFLAG="-D__RECORD_PATH__", it will show the path result
end

return WorldAoiManager