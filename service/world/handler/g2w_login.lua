local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"

function cmds.g2w_login(msg)
    local uid = msg.uid
    local fd = msg.fd
    con.addCon(uid, fd);
end