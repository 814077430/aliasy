local game = {}

local playerManager = require "playerManager"
game.playerManager = playerManager

function game.tick()
    game.playerManager:onTick()
end

return game