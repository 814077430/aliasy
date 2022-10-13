local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"

local worldManager = require "worldManager"

function cmds.d2w_worldIncrId(worldIncrId)
    worldManager.worldIncrId = worldIncrId 
end

function cmds.d2w_start(msg)
    for i = 1, #msg, 1 do
        for k, v in pairs(msg[i]) do
            if k ~= "unid" then
                msg[i][k] = xserialize.decodeToDb(k, v)
            end
        end
    end
end

function cmds.d2w_loadOver()
    
end