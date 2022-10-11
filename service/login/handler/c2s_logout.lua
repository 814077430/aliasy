local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local game = require "gameManager"

function cmds.c2s_logout(fd, msg)
    --notice other
	msg.fd = fd
	skynet.send(const.Game, "lua", "l2g_login", msg)

    --ret client
	local ret = {}
	ret.code = err.Success
    return ret
end