local skynet = require "skynet"
local const = require "const"
local xserialize = require "xserialize"
local RoleData = require "playerRoleDataManager"

local PlayerManager = {}
PlayerManager.players = {}
PlayerManager.onlines = {}
PlayerManager.acc2Uid = {}
PlayerManager.playerIncrId = 0
PlayerManager.dirtys = {}
PlayerManager.lastDay = 0

function PlayerManager.Player()
    local player = {}
    player.uid = 0
    player.account = ""
    player.roleData = nil

    return player
end

function PlayerManager.createPlayer(account)
    PlayerManager.playerIncrId = PlayerManager.playerIncrId + 1
    skynet.send(const.Db, "lua", "g2d_update_t_general", "playerIncrId", PlayerManager.playerIncrId)

    local player = PlayerManager.Player()
    
    player.account = account
    player.uid = const.PlayerUid + PlayerManager.playerIncrId
    skynet.send(const.Db, "lua", "g2d_insert_t_user", player.account, player.uid)

    player.roleData = RoleData.create()
    player.roleData.name = "noname"
    PlayerManager:addDirty(player.uid, "roleData")

    PlayerManager.players[player.uid] = player
    PlayerManager.onlines[player.uid] = player
    PlayerManager.acc2Uid[player.account] = player.uid
end

function PlayerManager.addDirty(uid, key)
    if not PlayerManager.dirtys[uid] then
        PlayerManager.dirtys[uid] = {}
    end

    PlayerManager.dirtys[uid][key] = 1
end

function PlayerManager.getPlayer(account)
    local uid = PlayerManager.acc2Uid[account]
    return PlayerManager.players[uid]
end

function PlayerManager.onStart()
    PlayerManager.lastDay =  math.ceil(math.ceil(skynet.time()) / const.OneDay)
end

function PlayerManager:onLogin(uid)

end

function PlayerManager:onLogout(uid)

end

function PlayerManager:crossDay()

end

function PlayerManager.onTick()
    --deal dirtys
    for k, v in pairs(PlayerManager.dirtys) do
        for k1, v1 in pairs(v) do
            local data = xserialize.encodeToDb(k1, PlayerManager.players[k][k1])
            skynet.send(const.Db, "lua", "g2d_update_t_user", k, k1, data)
        end
        PlayerManager.dirtys[k] = nil
    end

    --corss day
    local day = math.ceil(math.ceil(skynet.time()) / const.OneDay)
    if PlayerManager.lastDay ~= day then
        PlayerManager.lastDay = day
        PlayerManager.crossDay()
    end
end

return PlayerManager