-- to debug write these inline
--[[
paths.dofile('debug.lua')
vars = getLocalVars(localLevel['beforeDebug'])
keys = getTableKeys(vars)
debug.debug() -- insert `cont` or `Ctrl+d` to continue, insert double `Ctrl+c` to quit
]]

-- to print keys
--[[
print(keys[1])
or
print(keys) -- not working ?
or
for k, v in pairs(keys) do print(k, v) end
]]

-- to print values
--[[
print(vars[key])
or
val = vars[key] -- not working ?
print(val)
]]

localLevel = {}
localLevel['beforeDebug'] = 2
localLevel['afterDebug'] = 4

function getLocalVars(level)
    local ret = {}

    if level == nil then 
        level = localLevel['afterDebug']
    end

    local i = 1
    repeat
        name, val = debug.getlocal(level, i)
        if name then
            --print ("index", i, name, "=", val)
            ret[name] = val
            i = i + 1
        end -- if
    until not name
    return ret
end

function getTableKeys(tbl)
    local ret = {}
    local i = 0
    for key, val in pairs(tbl) do
        i = i + 1
        ret[i] = key
    end
    return ret
end

function getFunctionNames(obj)
    return getTableKeys(getmetatable(obj))
end
