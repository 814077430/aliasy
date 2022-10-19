local socket = require("socket.core")
local tcp = socket.tcp()
local host = "127.0.0.1"
local port = 30000

local con = tcp:connect(host, port)

if con then
    print("connect is ok ~")
end