local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"

--WorldManager
WorldManager = {
    length = const.WorldLength,
    width = const.Worldwidth,
    world = {},
    lastDay = 0,
}

function WorldManager:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.length = const.WorldLength
    self.width = const.Worldwidth
    self.world = {}
    self.lastDay = 0

    return o
end

function WorldManager:init()

end

function WorldManager:tick()

end

return WorldManager:new()