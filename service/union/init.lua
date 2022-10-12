local skynet = require "skynet"
local manager = require "skynet.manager"
local protobuf = require "protobuf"
local const = require "const"
local logger = require "log"
local cmds = require "cmds"
local lfs = require "lfs"

local UnionManager = require "unionManager"

local name = ""
local id = ""

local function __init__(name, id)
	name = name
	id = id
end

__init__(...)

local function __start__()
	logger.Debug("union service start")
	
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = cmds[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			logger.Debug("union unknow command : "..tostring(cmd))
		end
	end)
	
	--register name
	skynet.register(const.Union)

	--load handler
	for file in lfs.dir("./service/union/handler") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	--load structs
	for file in lfs.dir("./service/union/structs") do
		if file ~= "." and file ~= ".." then
			file = string.sub(file, 1, (#file-4))
			require(file)
		end
	end

	UnionManager:onStart()
	
	--start tick
	skynet.timeout(const.Internal, __tick__)
end

skynet.start(__start__)

function __tick__()
	UnionManager:onTick()
	skynet.timeout(const.Internal, __tick__)
end