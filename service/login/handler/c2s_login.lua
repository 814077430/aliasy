local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"
local game = require "gameManager"

function cmds.c2s_login(fd, msg)
	local p = game.playerManager:login(msg.account)
	con.addCon(p.uid, fd);
	
	--notice other
	local info = {}
	info.uid = p.uid
	info.fd = fd
	skynet.send(const.Game, "lua", "l2g_login", info)
	skynet.send(const.World, "lua", "l2w_login", info)

	--ret client
	local ret = {}
	ret.code = err.Success;
	ret.token = "";
	
	return ret;
end