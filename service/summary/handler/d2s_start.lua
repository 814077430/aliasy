local skynet = require "skynet"
local cmds = require "cmds"
local err = require "error"
local const = require "const"
local summaryManager = require "summaryManager"

function cmds.d2s_start(msg)
    if not msg or type(msg) ~= "table" then
        return
    end

    for i = 1, #msg do
        local uid = msg[i].uid
        summaryManager.players[uid] = msg[i]
    end
end