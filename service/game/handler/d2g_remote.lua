local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local xserialize = require "xserialize"
local playerManager = require "playerManager"

function cmds.d2g_playerIncrId(msg)
    playerManager.playerIncrId = msg[1].playerIncrId    
end

function cmds.d2g_start(msg)
    for i = 1, #msg, 1 do
        for k, v in pairs(msg[i]) do
            if k ~= "uid" and k ~= "account" then
                msg[i][k] = xserialize.decodeToDb(k, v)
            end
        end
        playerManager.players[msg[i].uid] = msg[i]
        playerManager.acc2Uid[msg[i].account] = msg[i].uid
    end

    playerManager:onStart()
end