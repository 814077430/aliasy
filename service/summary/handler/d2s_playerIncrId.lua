local skynet = require "skynet"
local cmds = require "cmds"
local err = require "error"
local const = require "const"
local summaryManager = require "summaryManager"

function cmds.d2s_playerIncrId(msg)
    summaryManager.playerIncrId = msg[1].incrId
end