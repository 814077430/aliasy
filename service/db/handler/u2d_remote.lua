local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local dbManager = require "dbManager"

function cmds.u2d_update_t_general(column, data)
    dbManager.db:query("update t_general set "..column.." = "..data)
end

function cmds.u2d_insert_t_union(unid)
    dbManager.db:query("insert into t_union set unid = "..unid)
end

function cmds.u2d_update_t_union(unid, column, data)
    local sql = dbManager.db:prepare("update t_union set "..column.." = ? where unid = "..unid)
    dbManager.db:execute(sql, data)
end
