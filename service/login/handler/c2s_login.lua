local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"
local util = require "util"

function cmds.c2s_login(fd, msg)
	--notice game
	msg.fd = fd
	skynet.send(const.Game, "lua", "l2g_login", msg)

	--third platform

	--ret client
	local ret = {}
	ret.code = err.Success
	ret.token = util.encryptData(skynet.starttime(), const.secret)
	
	return ret;
end