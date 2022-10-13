local skynet = require "skynet"
local con = require "connect"
local err = require "error"
local const = require "const"
local logger = require "log"

local jps = require "jps"

--WorldPathManager
local WorldPathManager = {}
WorldPathManager.j = nil

function WorldPathManager.init(length, width)
    WorldPathManager.j = jps.new({
        h = length,
        w = width,
        obstacle = {},
    })

    if not WorldPathManager.j then
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
            block = tonumber(string.sub(line, j, j))
            if block == 1 then
                WorldPathManager.j:add_block(i, j - 1)
            end
        end
        i = i + 1
    end
end

function WorldPathManager.add_block(x, y)
    WorldPathManager:add_block(x, y)
end

function WorldPathManager.findPath(x1, y1, x2, y2)
    WorldPathManager.j:set_start(x1, y1)
    WorldPathManager.j:set_end(x2, y2)
    WorldPathManager.j:mark_connected() 
    return WorldPathManager.j:find_path()
end

return WorldPathManager