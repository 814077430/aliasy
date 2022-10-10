local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"

function cmds.c2s_login(fd, msg)
	--notice other
	local info = {}
	info.uid = 1
	info.fd = fd
	skynet.send(const.Game, "lua", "l2g_login", info)
	skynet.send(const.World, "lua", "l2w_login", info)

	--ret client
	local ret = {}
	ret.code = err.Success;
	ret.token = "";
	
	return ret;
end