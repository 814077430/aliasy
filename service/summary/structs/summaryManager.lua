local skynet = require "skynet"
local err = require "error"
local const = require "const"

local summaryManager = {}

summaryManager.playerIncrId = 0
summaryManager.players = {}

return summaryManager