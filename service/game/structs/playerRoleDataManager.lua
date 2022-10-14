--RoleData
local PlayerRoleDataManager = {}

function PlayerRoleDataManager:create()
    local roleData = {}
    roleData.name = ""
    return roleData
end

return PlayerRoleDataManager