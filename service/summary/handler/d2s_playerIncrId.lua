local skynet = require "skynet"
local cmds = require "cmds"
local err = require "error"
local const = require "const"

local playerIncrId = 0

function cmds.d2s_playerIncrId(msg)
    playerIncrId = msg[1].incrId
end