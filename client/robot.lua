local socket = require "socket.core"
package.path = package.path..";".."./?.lua;"
local msgdef = require "msgdefine"
local xserialize = require "xserialize"

local host = "127.0.0.1"
local port = 30000
local robotNum = 10000
local tcps = {}

function sleep(n)
    socket.select(nil, nil, n)
end

for i = 1, robotNum do
    local tcp = socket.tcp()
    tcps[i] = tcp
    local fd = tcp:connect(host, port)

    if fd then
        print("connect ok ~")
    else
        print("connect error ~")
    end

    local pack = xserialize.encode(msgdef.c2s_login, {
        account = "aliasy"..i,
    })

    tcp:send(string.pack(">s2", pack))
end

for k, v in pairs(tcps) do
    sleep(1)
    if v then
        v:close()
        tcps[k] = nil
    end
end

while 1 do
end