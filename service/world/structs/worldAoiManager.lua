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

function WorldAoiManager:init(length, width)
    self.length = length
    self.width = width
    self.lenMax = math.ceil(self.length/const.TileLen)
    self.widMax = math.ceil(self.width/const.TileLen)

    for i = 1, self.lenMax do
        for j = 1, self.widMax do
            local tile = {}
            tile.watchers = {}
            tile.objs = {}
            if not self.tiles[i] then
                self.tiles[i] = {}
            end
            self.tiles[i][j] = tile
        end
    end
end

return WorldAoiManager