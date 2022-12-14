local skynet = require "skynet"
local manager = require "skynet.manager"
local logger = require "log"
local const = require "const"
local cmds = require "cmds"
local lfs = require "lfs"

local name = ""
local id = ""

local function __init__(name, id)
	name = name
	id = id
end

__init__(...)

local function __start__()
	logger.Debug("login service start")
	
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = cmds[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			logger.Debug("login unknow command : ", tostring(cmd))
		end
	end)
	
	--register name
	skynet.register(const.Login)

	--load handler
	for file in lfs.dir("./service/login/handler") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	--load structs
	for file in lfs.dir("./service/login/structs") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end
	
end

skynet.start(__start__)