local string = require "string"

local util = {}
 
function getByte(data, flag)
    local array = {}
    local lens = string.len(data)
    if flag == false then
        for i = 1, lens do
            array[i] = string.byte(data, i)
        end
        return array
    else
        for i=1, lens do
            array[i-1] = string.byte(data, i)
        end
    end
    return array, lens
end
 
function getChars(bytes)
    local array = {}
    for key, val in pairs(bytes) do
        array[key] = string.char(val)
    end
    return array
end

function util.split(str, reps)
    local resultStrList = {}
    string.gsub(str, '[^'..reps..']+', function(w)
        table.insert(resultStrList, w)
    end)

    return resultStrList
end
 
function util.encryptData(data, keys)
    local result = ""
    local dataArr = getByte(data, false)
    local keyArr, keyLen = getByte(keys, true)
    for index, value in pairs(dataArr) do
        result = result.."@"..tostring((0xFF and value) + (0xFF and keyArr[(index-1) % keyLen]))
    end
    return result
end
 
function util.decryptData(data, keys)
    local result = ""
    local dataArr = util.split(data, '@')
    local keyArr,keyLen = getByte(keys, true)
    for index, value in pairs(dataArr) do
          bytes =  tonumber(value) - (0xFF and keyArr[(index-1) % keyLen])
          result = result..string.char(bytes)
    end
    return result
end

return util