local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local playerManager = require "playerManager"

function cmds.c2s_getPlayerData(fd, msg)
    local uid = con.playerFds(fd)
    local player = playerManager.players[uid]

    playerManager.onLogin(uid)

    local ret = {}
    ret.code = err.Success
    ret.account = player.account
    ret.uid = player.uid
    ret.roleData = {}
    ret.roleData.name = player.roleData.name

    return ret
end