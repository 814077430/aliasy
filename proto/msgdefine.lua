M = {}
msg_map = {}
M = 
{
    c2s_login = 10001,
    s2c_login = 10002,
    c2s_logout = 10003,
    s2c_logout = 10004,
}

for msgname, msgid in pairs(M) do 
   msg_map[msgid] = "pb."..msgname 
end

function M.get_name(msgid)
   return msg_map[msgid]
end

return M