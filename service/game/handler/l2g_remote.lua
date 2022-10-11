local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local playerManager = require "playerManager"

function cmds.l2g_login(msg)
    local acc = msg.acc
    local fd = msg.fd

    if not playerManager.acc2Uid[acc] then
        playerManager.createPlayer(acc)
    end

    con.addCon(uid, fd);
end