local skynet = require "skynet"
local manager = require "skynet.manager"
local mysql = require "skynet.db.mysql"
local const = require "const"
local logger = require "log"
local cmds = require "cmds"
local lfs = require "lfs"

local db = nil
local name = ""
local id = ""

local function __init__(name, id)
	name = name
	id = id
end

__init__(...)

function __start__()
	logger.Debug("db service start")
	
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
	
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = cmds[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			logger.Debug("db unknow command : ", tostring(cmd))
		end
	end)
	
	--register name
	skynet.register(const.Db)

	--load handler
	for file in lfs.dir("./service/db/handler") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	--load structs
	for file in lfs.dir("./service/db/structs") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	skynet.timeout(const.Internal, __tick__)
end

skynet.start(__start__)

function __tick__()
	skynet.timeout(const.Internal, __tick__)
end