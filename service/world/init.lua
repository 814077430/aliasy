local skynet = require "skynet"
local manager = require "skynet.manager"
local const = require "const"
local logger = require "log"
local cmds = require "cmds"
local lfs = require "lfs"

local worldManager = require "worldManager"

local name = ""
local id = ""

local function __init__(name, id)
	name = name
	id = id
end

__init__(...)

local function __start__()
	logger.Debug("world service start")
	
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = cmds[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			logger.Debug("world unknow command : ", tostring(cmd))
		end
	end)
	
	--register name
	skynet.register(const.World)

	--load handler
	for file in lfs.dir("./service/world/handler") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	--load structs
	for file in lfs.dir("./service/world/structs") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	worldManager:onInit()

	--start tick
	skynet.timeout(const.Internal, __tick__)
end

skynet.start(__start__)

function __tick__()
	worldManager:onTick()
	skynet.timeout(const.Internal, __tick__)
end