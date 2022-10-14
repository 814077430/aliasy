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
        playerManager.createPlayer(account)
    end

    local player = playerManager:getPlayer(account)

    if not player then
        return
    end

    con.addCon(player.uid, fd);

    skynet.send(const.World, "lua", "g2w_login", player.uid, fd)
    skynet.send(const.Union, "lua", "g2u_login", player.uid, fd)
end

function cmds.l2g_logout(msg)
    local account = msg.account
    local fd = msg.fd

    local uid = playerManager.acc2Uid[account]
    if not uid then
        return
    end

    local player = playerManager.getPlayer(account)
    if not player then
        return
    end

    con.delCon(uid)
    playerManager.onLogout(uid)
end