local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local game = require "gameManager"

function cmds.c2s_logout(fd, msg)
	local uid = con.playerFds[fd]
    local player = game.playerManager:getPlayer(uid)
end