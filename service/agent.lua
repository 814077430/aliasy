local skynet = require "skynet"
local socket = require "skynet.socket"
local msgdef = require "msgdefine"
local xserialize = require "xserialize"
local const = require "const"

local fd 
local CMD = {}
local ROUTE = {};

ROUTE[1] = function(name, data)
	return pcall(skynet.call, const.Game, "lua", name, skynet.self(), data)
end

ROUTE[2] = function(name, data)
	return pcall(skynet.call, const.World, "lua", name, skynet.self(), data)
end

skynet.register_protocol {
    name = "client",
    id = skynet.PTYPE_CLIENT,
    unpack = skynet.tostring,
    dispatch = function(session, address, msg)
        local name, id, data = xserialize.decode(msg)
		name = string.sub(name, 4, #name) -- pb.
		local r = id // 10000
		if ROUTE[r] then
			local ok, ret = ROUTE[r](name, data)
			if ok then
				local pack = xserialize.encode(id + 1, ret)
				socket.write(fd, string.pack(">s2", pack))
			else
				skynet.error("not ret: ", name, id)
			end
		else
			skynet.error("not proto: ", name, id)
		end
		
		skynet.ignoreret()
    end,
}

function CMD.start(conf)
    local gate = conf.gate
    fd = conf.client

    skynet.call(gate, "lua", "forward", fd)
end

function CMD.close()
    skynet.exit()
end

function CMD.disconnect()
    -- todo: do something before exit
    skynet.exit()
end

function CMD.push(msg)
	local protoname = msg.protoname;
	msg.protoname = nil
	msg = xserialize.encode(msgdef[protoname], msg)
	socket.write(fd, string.pack(">s2", msg))
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = CMD[command]
        assert(f, command)
        skynet.ret(skynet.pack(f(...)))
    end)
end)