local msgdef = require "msgdefine"
local protobuf = require "protobuf"
protobuf.register_file("./messages.pb")

local xserialize = {}

function xserialize.encode(msgid, data)
    local msgname = msgdef.get_name(msgid)
    local stringbuffer = protobuf.encode(msgname, data)
    return string.pack(">I2s2", msgid, stringbuffer)
end

function xserialize.decode(msg)
    local msgid, stringbuffer = string.unpack(">I2s2", msg)
    local protoname = msgdef.get_name(msgid)
    local body = protobuf.decode(protoname, stringbuffer)
    return protoname, msgid, body
end

function xserialize.encodeToDb(msgname, data)
    local stringbuffer = protobuf.encode("pb."..msgname, data)
    return stringbuffer
end

function xserialize.decodeToDb(msgname, buffer)
    local body = protobuf.decode("pb."..msgname, buffer)
    return body
end

return xserialize
