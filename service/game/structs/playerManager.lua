local skynet = require "skynet"
local const = require "const"
local RoleData = require "playerRoleDataManager"

--Player
Player = {
    uid = 0,
    account = "",
    roleData = nil
}

function Player:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.uid = 0
    self.account = ""
    self.roleData = nil

    return o
end

--PlayerManager
PlayerManager = {
    players = {},
    onlines = {},
    acc2Uid = {},
    playerIncrId = 0
}

function PlayerManager:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.players = {}
    self.onlines = {}
    self.acc2Uid = {}
    self.summary = {}
    self.playerIncrId = 0

    return o
end

function PlayerManager:createPlayer(account)

end

function PlayerManager:getPlayer(uid)

end

function PlayerManager:login()

end

function PlayerManager:logout()

end

function PlayerManager:tick()

end

return PlayerManager:new()