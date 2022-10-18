package.cpath = "./skynet/luaclib/?.so;"
package.path = "./skynet/lualib/?.lua;./skynet/examples/?.lua;./lualib/?.lua;./proto/?.lua;"

local skynet = require "skynet"
local socket = require "skynet.socket"
local msgdef = require "msgdefine"
local xserialize = require "xserialize"

local max_num = 100
local robots = {}

local function send_data(fd)
    while true do
        skynet.sleep(500)
        local pack = xserialize.encode(msgdef.c2s_login, {
            account = "aliasy",
        })
		
		local msgname, msgid, body = xserialize.decode(pack)
		skynet.error("c2s ==================== : ", msgname, msgid, body.account)	
        socket.write(fd, string.pack(">s2", pack))
    end
end

skynet.start(function()
    for i = 1, max_num do
        local fd = socket.open("127.0.0.1", 30000)
        skynet.fork(send_data, fd)
    end
end)
