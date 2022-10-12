local skynet = require "skynet"
local const = require "const"

--Union
Union = {
    unid = 0,
    baseData = nil,
}

function Union:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.unid = 0
    self.baseData = nil

    return o
end

--UnionManager
UnionManager = {
    unionIncrId = 0,
    unions = {},
    dirtys = {},
    lastDay = 0,
}

function UnionManager:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.unionIncrId = 0
    self.unions = {}
    self.dirtys = {} -- unid : {'baseData' : 1, 'memberData' : 1 ...}
    self.lastDay = 0

    return o
end

function UnionManager:addDirty(unid, key)
    if not self.dirtys[unid] then
        self.dirtys[unid] = {}
    end

    self.dirtys[unid][key] = 1
end

function UnionManager:onStart()
    self.lastDay =  math.ceil(math.ceil(skynet.time()) / const.OneDay)
end

function UnionManager:crossDay()

end

function UnionManager:onTick()
    --deal dirtys
    for k, v in pairs(self.dirtys) do
        for k1, v1 in pairs(v) do
            local data = xserialize.encodeToDb(k1, self.unions[k][k1])
            skynet.send(const.Db, "lua", "u2d_update_t_union", k, k1, data)
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

return UnionManager:new()
