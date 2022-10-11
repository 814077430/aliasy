local skynet = require "skynet"
local con = require "connect"
local err = require "error"
local const = require "const"
local worldAoiManager = require "worldAoiManager"

--WorldManager
WorldManager = {}

WorldManager.world = nil
WorldManager.lastDay = 0

function WorldManager.init()
    WorldManager.lastDay = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    worldAoiManager.init(const.WorldLength, const.Worldwidth)
end

function WorldManager.tick()
    --corss day
    local day = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    if WorldManager.lastDay ~= day then
        WorldManager.lastDay = day
        --to do cross day

    end
end

return WorldManager