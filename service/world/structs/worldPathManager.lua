local skynet = require "skynet"
local con = require "connect"
local err = require "error"
local const = require "const"
local logger = require "log"

local jps = require "jps"

--WorldPathManager
local WorldPathManager = {}
WorldPathManager.j = nil

function WorldPathManager:onInit(length, width)
    self.j = jps.new({
        h = length,
        w = width,
    })

    if not self.j then
        logger.Debug("WorldPathManager.init:jps error")
        return
    end

    local file = io.open("./table/block.bytes", "r")
    if not file then
        logger.Debug("WorldPathManager.init:block.bytes is not exsits")
        return
    end

    local line = ""
    local block
    local i = 0
    local j = 1
    while line do
        line = file:read()
        if not line then break end
        for j = 1, width do
            block = string.sub(line, j, j)
            if block == "1" then
                self.j:add_block(i, j - 1)
            end
        end
        i = i + 1
    end
end

function WorldPathManager:addBlock(x, y)
    self.j:add_block(x, y)
end

function WorldPathManager:clearBlock(x, y)
    self.j:clear_block(x, y)
end

function WorldPathManager:checkBlock(x, y)
    self.j:check_block(x, y)
end

function WorldPathManager:findPath(x1, y1, x2, y2)
    self.j:set_start(x1, y1)
    self.j:set_end(x2, y2)
    self.j:mark_connected() 
    return self.j:find_path()
end

return WorldPathManager