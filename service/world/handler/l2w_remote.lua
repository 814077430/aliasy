local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"

function cmds.l2w_login(uid, fd)
    con.addCon(uid, fd);
end