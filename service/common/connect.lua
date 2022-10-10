local skynet = require "skynet"

local con = {}
local playerCons = {} -- uid : agent
local playerFds = {} -- agent : uid

function con.addCon(uid, fd)
	playerCons[uid] = fd
end

function con.delCon(uid)
	playerCons[uid] = nil
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