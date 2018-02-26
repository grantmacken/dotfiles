local _M = {}

function _M.echom(message)
  vim.api.nvim_command('echom "' .. tostring(message) .. '"')
end


function _M.read(f)
  local open     = io.open
  local f, e = open(f, "rb")
  if not f then
    return nil, e
  end
  local c = f:read "*a"
  f:close()
  return c
end

-- TODO if not in use remove

function _M.tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-- TODO if not in use remove

function _M.contains( T, val )
  for index, value in ipairs (T) do
    if value == val then
      return true
    end
  end
  return false
end

-- isArray
-- Determine with a Lua table can be treated as an array.
-- Explicitly returns "not an array" for very sparse arrays.
-- Returns:
-- -1   Not an array
-- 0    Empty table
-- >0   Highest index in the array
function _M.isArray(T)
    local max = 0
    local count = 0
    for k, v in pairs(T) do
        if type(k) == "number" then
            if k > max then max = k end
            count = count + 1
        else
            return -1
        end
    end
    if max > count * 2 then
        return -1
    end
    return max
end

-- listKeys
-- Returns: string
--  as a bar separated list of keys
function _M.listKeys( T )
  local t = {}
  for k, v in pairs(T) do
    table.insert(t, tostring(k))
  end
  return table.concat(t," | ")
end

function _M.printIPairs( T )
  -- print( type(v))
  for i, v in ipairs( T ) do
    -- print( type(v))
    if type(v) == "string" then
      print( tostring(i) .. ', value: '  .. v )
    end
    if type(v) == "number" then
      print( tostring(i) .. ', value: '  .. tostring(v) )
    end
    if type(v) == "table" then
      if util.isArray( v ) > 0 then
        printIPairs( v )
      end
    end
  end
end

function _M.printPairs( T , spacer )
  for k, v in pairs( T ) do
    -- print( type(v))
    if type(v) == "string" then
      print( spacer .. 'key:' .. k .. ', value: '  .. v )
    end
    if type(v) == "number" then
      print(  spacer .. 'key: ' .. tostring(k) .. ', value: '  .. tostring(v) )
    end
    if type(v) == "table" then
      print( spacer .. ' key:: ' .. tostring(k) )
      spacer = spacer .. '  '
      if util.isArray( v ) < 0 then
        printPairs( v , spacer )
      end
      if util.isArray( v ) == 0 then
        print( spacer .. 'EMPTY TABLE: ' .. tostring(util.isArray( v )))
      end
      if util.isArray( v ) > 0 then
        print( spacer .. 'TODO ARRAY TABLE')
       -- printPairs(instance)
      end
      spacer = ' '
    end
  end
end


return _M
