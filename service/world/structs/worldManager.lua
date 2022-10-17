local skynet = require "skynet"
local con = require "connect"
local err = require "error"
local const = require "const"

local worldPathManager = require "worldPathManager"
local worldAoiManager = require "worldAoiManager"

--WorldManager
WorldManager = {}

WorldManager.worldIncrId = 0
WorldManager.world = nil
WorldManager.lastDay = 0

function WorldManager.init()
    WorldManager.lastDay = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    worldPathManager:init(const.WorldLength, const.Worldwidth)
    worldAoiManager:init(const.WorldLength, const.Worldwidth)
end

function WorldManager.crossDay()

end

function WorldManager.tick()
    --corss day
    local day = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    if WorldManager.lastDay ~= day then
        WorldManager.lastDay = day
        WorldManager.crossDay()
    end
end

return WorldManager