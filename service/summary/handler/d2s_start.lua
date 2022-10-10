local skynet = require "skynet"
local cmds = require "cmds"
local err = require "error"
local const = require "const"

function cmds.d2s_start(msg)
    if not msg or type(msg) ~= "table" then
        return
    end

    for i = 1, #msg do
        
    end
end