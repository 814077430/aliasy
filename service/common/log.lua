local skynet = require "skynet"

Log = {}

function Log.Debug(...)
	skynet.error("[Debug]", os.date("%Y-%m-%d %X", skynet.starttime()), ...)
end

function Log.Trace(...)
    skynet.error("[Trace]", ..., debug.traceback())
end

return Log