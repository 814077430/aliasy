local game = {}

local playerManager = require "playerManager"
game.playerManager = playerManager

function game.tick()
    game.playerManager:tick()
end

return game