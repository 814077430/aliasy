local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"
local playerManager = require "playerManager"

function cmds.l2g_login(msg)
    local account = msg.account
    local fd = msg.fd

    if not playerManager.acc2Uid[account] then
        playerManager:createPlayer(account)
    end

    local player = playerManager:getPlayer(account)
    con.addCon(player.uid, fd);

    skynet.send(const.World, "lua", "l2w_login", player.uid, fd)
end