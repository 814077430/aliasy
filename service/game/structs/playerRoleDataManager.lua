--RoleData
RoleData = {
    name = "",
}

function RoleData:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.name = ""

    return o
end

function RoleData:getName()
    return self.name
end

return RoleData