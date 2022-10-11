local skynet = require "skynet"
local cmds = require "cmds"
local con = require "connect"
local err = require "error"
local dbManager = require "dbManager"

function cmds.g2d_update_t_general(column, data)
    dbManager.db:query("update t_general set "..column.." = "..data)
end

function cmds.g2d_insert_t_user(account, uid)
    dbManager.db:query("insert into t_user set account = '"..account.."', uid = "..uid)
end

function cmds.g2d_update_t_user(uid, column, data)
    local sql = dbManager.db:prepare("update t_user set ? = ? where uid = ?")
    local ret = dbManager.db:execute(sql, column, data, uid)
    
end