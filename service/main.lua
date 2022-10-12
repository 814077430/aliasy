local skynet = require "skynet"
local socket = require "skynet.socket"
local const = require "const"
local logger = require "log"

local function init()
	logger.Debug("server start")
	
	local battle = skynet.newservice("battle")
	local chat = skynet.newservice("chat")
	local game = skynet.newservice("game")
	local world = skynet.newservice("world")
	local union = skynet.newservice("union")
	local login = skynet.newservice("login")
	local db = skynet.newservice("db")
	
	local watchdog = skynet.newservice("watchdog")
	local addr, port = skynet.call(watchdog, "lua", "start", {
		port = 30000,
		maxclient = const.MaxClient,
		nodelay = true,
	})
	
	logger.Debug("watchdog listen on " .. addr .. ":" .. port)
	
	--test client
	local client = skynet.newservice("client")
	
	skynet.exit()
end

skynet.start(init)