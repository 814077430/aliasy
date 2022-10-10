local mysql = require "skynet.db.mysql"
local logger = require "log"

local dbManager = {}
local db = nil

function dbManager.init()
    db = mysql.connect({
        host = "127.0.0.1",
        port = 3306,
        database = "aliasy",
        user = "root",
        password = "test",
        charset = "utf8",
        max_packet_size = 1024 * 1024,
        on_connect = nil
    })
    
    if not db then
        logger.Debug("connect to mysql server failed")
        return
    end
    
    logger.Debug("connect to mysql server success")
end

function dbManager.serverStart()
    
end

return dbManager