local skynet = require "skynet"

local con = {}
local playerCons = {} -- uid : agent
local playerFds = {} -- agent : uid

function con.addCon(uid, fd)
	playerCons[uid] = fd
	playerFds[fd] = uid
end

function con.delCon(uid)
	local fd = playerCons[uid]
	playerCons[uid] = nil
	playerFds[fd] = nil
end

function con.getUid(fd)
	return playerFds[fd]
end

function con.push(uid, msg)
	skynet.send(playerCons[uid], "lua", "push", msg)
end

function con.broadcast(all, msg)
	for i = 1, #all do
		skynet.send(playerCons[all[i]], "lua", "push", msg)
	end
end

return con