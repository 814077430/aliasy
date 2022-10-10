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
    self.playerIncrId = 0

    return o
end

function PlayerManager:login(account)
    if not self.acc2Uid[account] then
        self:createPlayer(account)
    end

    local uid = self.acc2Uid[account]

    return self.players[uid]
end

function PlayerManager:createPlayer(account)
    self.playerIncrId = self.playerIncrId + 1
    uid = const.PlayerUid + self.playerIncrId
    
    --init
    local player = Player:new()
    player.uid = uid
    player.account = account
    player.roleData = RoleData:new()
    player.roleData.name = "noname"

    self.players[uid] = player
    self.onlines[uid] = player
    self.acc2Uid[account] = uid
end

function PlayerManager:getPlayer(uid)
    return self.players[uid]
end

function PlayerManager:logout()

end

function PlayerManager:tick()

end

return PlayerManager:new()