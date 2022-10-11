local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local util = require "util"
local playerManager = require "playerManager"

function cmds.c2s_getPlayerData(fd, msg)
    local ret = {}
    ret.code = err.Success

    local tc = tonumber(util.decryptData(msg.token, const.secret))
    if (skynet.starttime() - tc) > const.tokenTime then
        ret.code = err.TokenInvalid
        return ret      
    end 

    local uid = con.getUid(fd)
    if not uid then
        ret.code = err.NoPlayer
        return ret
    end

    local player = playerManager.players[uid]
    if not player then
        ret.code = err.NoPlayer
        return ret
    end

    playerManager.onLogin(uid)

    ret.account = player.account
    ret.uid = player.uid
    ret.roleData = {}
    ret.roleData.name = player.roleData.name

    return ret
end