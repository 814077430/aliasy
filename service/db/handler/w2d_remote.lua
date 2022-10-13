local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local dbManager = require "dbManager"

function cmds.w2d_update_t_general(column, data)
    dbManager.db:query("update t_general set "..column.." = "..data)
end

function cmds.w2d_insert_t_world(eid)
    dbManager.db:query("insert into t_world set eid = "..eid)
end

function cmds.w2d_update_t_world(uid, column, data)
    local sql = dbManager.db:prepare("update t_world set "..column.." = ? where uid = "..uid)
    dbManager.db:execute(sql, data)
end
