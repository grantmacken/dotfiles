
--[[
--  develop stuff here
--  run
--  luafile $DATAPATH/lua/my/run.lua
--  turn imto module
--]]

local cjson = require('cjson')
local util = require('my.util')
local fs = require('my.fs')
local project = require('my.project')
local api = vim.api

  -- local buf = api.nvim_get_current_buf()
  -- local line = api.nvim_get_current_line()
  -- local pos = api.nvim_win_get_-cursor(win)
  --local winNum = api.nvim_win_get_number(win)
  --local buf = api.nvim_win_get_buf(win)
  -- local buf = api.nvim_win_get_buf(win)
  -- local bufMark = api.nvim_buf_get_mark(buf,'M')
  -- local bufName = api.nvim_buf_get_name(buf)
  -- local bufChangedTick = api.nvim_buf_get_changedtick(buf)
  -- local bufOpt = api.nvim_buf_get_option(winBuf,'projectionist')
  -- local bufOpt = api.nvim_buf_get_var(winBuf,'projectionist')
  -- local row = pos[1]
  -- local col = pos[2]
  --  -- local bufs = api.nvim_list_bufs()
  -- util.echom( cjson.encode(bufs) )
  -- util.echom( util.isArray( bufs ))


--[[
-- Get Relative Path
--]]
local function getRelativePath( dProjectPath , fPath )
  --local iProjectPathLength =  string.len(dProjectPath) + 2
  local iProjectPathLength =  api.nvim_strwidth(dProjectPath) +2
  return string.sub( fPath, iProjectPathLength )
end

local function findBufNameInWin( dProjectPath, fName )
  local wins = api.nvim_list_wins()
  local winFound
  for i, window in ipairs(wins) do
    local buffer = api.nvim_win_get_buf(window)
    local bufferName = api.nvim_buf_get_name( buffer )
    local fBuf = getRelativePath( dProjectPath, bufferName)
    if fBuf == fName then
      winFound = window
      break
    end
  end
 return winFound
end

local function findCmdInTermWin( sCmd )
  local wins = api.nvim_list_wins()
  local winFound
  local buffer
  local bufferName
  for i, window in ipairs(wins) do
    buffer = api.nvim_win_get_buf(window)
    local bufferType = api.nvim_buf_get_option( buffer, 'buftype' )
    bufferName = api.nvim_buf_get_name( buffer )
    if bufferType == 'terminal' then
      local nameFound = string.find( bufferName, sCmd )
      if nameFound ~= nil then
        winFound = window
      end
    end
  end
  return winFound, bufferName, buffer
end


local function onStdOut()
  return
end

local function onStdErr()
  return
end

local function onExit()
  return
end

local function displayTerm()
  api.nvim_command('DeleteHiddenBuffers')
  local arr = {}
  local dProjectPath = api.nvim_call_function('projectionist#path',arr)
  arr[1] = 'term'
  local sTermCommand = api.nvim_call_function('my#project#value',arr)
  -- util.echom( type(sTermCommand) )
  if type(sTermCommand) ~= 'string' then
    return
  end
  local oOpts = {
    sTermCommand,
    ['on_stdout'] = onStdOut(),
    ['on_stderr'] = onStdErr(),
    ['on_exit'] = onExit()
  }
  -- util.echom( 'create new window' )
  -- util.echom( ' - execute term command: ' ..  sTermCommand )
  local placeHolderWindow = api.nvim_get_current_win()
  local winFound, bufferName, buffer = findCmdInTermWin( sTermCommand )
  if winFound then
    -- util.echom( ' - window: ' .. tostring(winFound))
    -- util.echom( ' - bufferName: ' .. bufferName)
    -- util.echom( ' - buffer: ' .. tostring(buffer))
    api.nvim_set_current_win(winFound)
    api.nvim_set_current_buf(buffer)
    api.nvim_command('bw!')
  end
  api.nvim_command('botright new')
  api.nvim_call_function('termopen',oOpts)
  api.nvim_set_current_win(placeHolderWindow)
end

local function isGlobalVar( v )
  local value = api.nvim_get_var( v )
  if type(value) ~= 'number' then
    return false
  else
    if value == 1 then
      return true
    else 
      return false
    end
  end
end

local function isBufferVar( v )
  local window = api.nvim_get_current_win() 
  local buffer = api.nvim_win_get_buf(window)
  local value = api.nvim_buf_get_var( buffer, v )
  if type(value) ~= 'table' then
    return false
  else
    return true
  end
end

local bNext, err = pcall( api.nvim_command,'cnext')

if not cNext then
  util.echom( ' - err: ' .. err)
  local bFirst, err = pcall( api.nvim_command,'cfirst')
end

-- util.echom( ' - window: ' .. type(cNext))



-- local gLoaded, err = pcall(isGlobalVar,'autoloaded_projectionist')
-- local bLoaded, err = pcall(isBufferVar,'projectionist')
-- -- util.echom(  gLoaded )
-- -- util.echom(  bLoaded )
-- project.openInTerminalWindow('term')
-- project.openInSplitWindow('log')
-- util.echom(  err )


