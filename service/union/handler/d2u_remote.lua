local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"

local unionManager = require "unionManager"

function cmds.d2u_unionIncrId(unionIncrId)
    unionManager.unionIncrId = unionIncrId 
end

function cmds.d2u_start(msg)
    for i = 1, #msg, 1 do
        for k, v in pairs(msg[i]) do
            if k ~= "unid" then
                msg[i][k] = xserialize.decodeToDb(k, v)
            end
        end
        unionManager.unions[msg[i].unid] = msg[i]
    end
end