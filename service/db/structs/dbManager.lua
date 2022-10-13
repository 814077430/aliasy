local skynet = require "skynet"
local mysql = require "skynet.db.mysql"
local logger = require "log"
local const = require "const"

local dbManager = {}
dbManager.db = nil

function dbManager.init()
    dbManager.db = mysql.connect({
        host = skynet.getenv("mysql_host"),
        port = skynet.getenv("mysql_port"),
        database = skynet.getenv("mysql_database"),
        user = skynet.getenv("mysql_user"),
        password = skynet.getenv("mysql_pwd"),
        charset = "utf8mb4",
        max_packet_size = 1024 * 1024,
        on_connect = nil
    })
    
    if not dbManager.db then
        logger.Debug("connect to mysql server failed")
        return
    end
    
    logger.Debug("connect to mysql server success")
end

function dbManager.start()
    local data
    local res = dbManager.db:query("select playerIncrId, unionIncrId, worldIncrId from t_general")
    
    --game
    skynet.send(const.Game, "lua", "d2g_playerIncrId", res[1].playerIncrId)
    
    for i = 1, res[1].playerIncrId, const.DbLoadNum do
        data = dbManager.db:query("select account, uid, roleData from t_user where id >= "..i.." and id < "..(i + const.DbLoadNum))
        skynet.send(const.Game, "lua", "d2g_start", data)
    end

    --union
    skynet.send(const.Union, "lua", "d2u_unionIncrId", res[1].unionIncrId)

    for i = 1, res[1].unionIncrId, const.DbLoadNum do
        data = dbManager.db:query("select unid, baseData from t_union where id >= "..i.." and id < "..(i + const.DbLoadNum))
        skynet.send(const.Union, "lua", "d2u_start", data)
    end

    --world
    skynet.send(const.World, "lua", "d2w_worldIncrId", res[1].worldIncrId)

    for i = 1, res[1].worldIncrId, const.DbLoadNum do
        data = dbManager.db:query("select eid, entityData from t_world where id >= "..i.." and id < "..(i + const.DbLoadNum))
        skynet.send(const.World, "lua", "d2g_start", data)
    end

    skynet.send(const.Game, "lua", "d2g_loadOver")
    skynet.send(const.Union, "lua", "d2u_loadOver")
    skynet.send(const.World, "lua", "d2w_loadOver")
end

return dbManager