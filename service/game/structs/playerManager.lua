local skynet = require "skynet"
local const = require "const"
local xserialize = require "xserialize"
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
    playerIncrId = 0,
    dirtys = {},
    lastDay = 0,
}

function PlayerManager:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.playerIncrId = 0
    self.players = {}
    self.onlines = {}
    self.acc2Uid = {}

    self.dirtys = {} -- uid : {'roleData' : 1, 'itemData' : 1 ...}

    self.lastDay = 0

    return o
end

function PlayerManager:createPlayer(account)
    self.playerIncrId = self.playerIncrId + 1
    skynet.send(const.Db, "lua", "g2d_update_t_general", "playerIncrId", self.playerIncrId)

    local player = Player:new()
    
    player.account = account
    player.uid = const.PlayerUid + self.playerIncrId
    skynet.send(const.Db, "lua", "g2d_insert_t_user", player.account, player.uid)

    player.roleData = RoleData:new()
    player.roleData.name = "noname"
    self:addDirty(player.uid, "roleData")

    self.players[player.uid] = player
    self.onlines[player.uid] = player
    self.acc2Uid[player.account] = player.uid
end

function PlayerManager:addDirty(uid, key)
    if not self.dirtys[uid] then
        self.dirtys[uid] = {}
    end

    self.dirtys[uid][key] = 1
end

function PlayerManager:getPlayer(account)
    local uid = self.acc2Uid[account]
    return self.players[uid]
end

function PlayerManager:onStart()
    self.lastDay =  math.ceil(math.ceil(skynet.time()) / const.OneDay)
end

function PlayerManager:onLogin(uid)

end

function PlayerManager:onLogout(uid)

end

function PlayerManager:crossDay()

end

function PlayerManager:onTick()
    --deal dirtys
    for k, v in pairs(self.dirtys) do
        for k1, v1 in pairs(v) do
            local data = xserialize.encodeToDb(k1, self.players[k][k1])
            skynet.send(const.Db, "lua", "g2d_update_t_user", k, k1, data)
        end
        self.dirtys[k] = nil
    end

    --corss day
    local day = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    if self.lastDay ~= day then
        self.lastDay = day
        self:crossDay()
    end
end

return PlayerManager:new()