local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"

function cmds.g2u_login(uid, fd)
    con.addCon(uid, fd);
end