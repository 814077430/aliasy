local game = {}

local playerManager = require "playerManager"
game.playerManager = playerManager

function game.onStart()

end

function game.onTick()
    game.playerManager:onTick()
end

return game