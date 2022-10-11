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

    self.playerIncrId = 0
    self.players = {}
    self.onlines = {}
    self.acc2Uid = {}

    return o
end

function PlayerManager:createPlayer(account)
    local player = Player:new()
    self.playerIncrId = self.playerIncrId + 1
    player.uid = const.PlayerUid + self.playerIncrId
    player.account = account
    player.roleData = RoleData:new()
    self.players[player.uid] = player
    self.onlines[player.uid] = player
    self.acc2Uid[player.account] = player.uid
end

function PlayerManager:getPlayer(account)
    local uid = self.acc2Uid[account]
    return self.players[uid]
end

function PlayerManager:onLogin()
    
end

function PlayerManager:onLogout()

end

function PlayerManager:tick()

end

return PlayerManager:new()