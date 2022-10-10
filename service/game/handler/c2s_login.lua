local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local const = require "const"
local game = require "gameManager"

function cmds.c2s_login(fd, msg)
	local p = game.playerManager:login(msg.account)
	con.addCon(p.uid, fd);
	
	--notice world
	local info = {}
	info.uid = p.uid
	info.fd = fd
	skynet.send(const.World, "lua", "g2w_login", info)

	--ret client
	local ret = {}
	ret.code = err.Success;
	ret.data = {};
	ret.data.account = msg.account;
	ret.data.uid = p.uid;
	ret.data.roleData = {}
	ret.data.roleData.name = p.roleData.name
	
	return ret;
end