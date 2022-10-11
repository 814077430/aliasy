local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local playerManager = require "playerManager"

function cmds.d2g_playerIncrId(msg)
    playerManager.playerIncrId = msg[1].playerIncrId    
end

function cmds.d2g_start(msg)
    for i = 1, #msg, 1 do
        playerManager.players[msg[i].uid] = msg
        playerManager.acc2Uid[msg[i].acc] = msg[i].uid
    end
end