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

function WorldManager:onInit()
    self.lastDay = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    worldPathManager:onInit(const.WorldLength, const.Worldwidth)
    worldAoiManager:onInit(const.WorldLength, const.Worldwidth)
end

function WorldManager:crossDay()

end

function WorldManager:onTick()
    --corss day
    local day = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    if self.lastDay ~= day then
        self.lastDay = day
        self:crossDay()
    end
end

return WorldManager