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
end

return WorldAoiManager