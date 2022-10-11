local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"
local util = require "util"

function cmds.c2s_login(fd, msg)
	--third platform

	--notice game
	msg.fd = fd
	skynet.send(const.Game, "lua", "l2g_login", msg)

	--ret client
	local ret = {}
	ret.code = err.Success
	ret.token = util.encryptData(skynet.time(), const.secret)
	
	return ret;
end