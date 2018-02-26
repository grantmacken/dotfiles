local _M = {}

local cjson = require('cjson')
local util = require('my.util')
local fs = require('my.fs')
local api = vim.api

--[[
-- :NvimAPI
-- :h api
-- :h lua
-- :command " to list commands
-- api.nvim_command('echom "' .. tostring(message) .. '"')
-- api.nvim_call_function( 'neoterm#tnew,{}')
--  :h termopen
-- print( util.listKeys(nt))
--   $DATAPATH
--]]

-- function! my#project#init() abort
--   lua 
--   for [root, value] in projectionist#query('framework')
--     " echomsg value
--     " lua vim.api.nvim_set_var('framework', value)
--     break
--   endfor
-- endfunction
-- buffers(api)
-- api.nvim_command('echom "OK"')
-- local win = api.nvim_get_current_win()
-- local winNum = api.nvim_win_get_number(win)
-- local winBuf = api.nvim_win_get_buf(win)
-- print( winBuf )
--  print( winNum )
--  print( api.nvim_eval('$DATAPATH') )
--  print( api.nvim_eval('expand("$CACHEPATH/*")') )
-- -- print(api.nvim_call_function( 'win_getid',{}))
-- --- api.nvim_command('DeleteHiddenBuffers')
-- local nt = api.nvim_get_var('neoterm')
-- print( nt['last_id'] )
-- print( nt['open'] )

-- print( type(nt['instances']) )
-- local nt = api.nvim_get_var('neoterm')
-- -- print( type(nt['instances']) )
-- -- api.nvim_call_function('g:neoterm.has_any',{})
-- local hasAny = api.nvim_eval('g:neoterm.has_any()')
--  print( type(hasAny) )
-- print( hasAny )
-- api.nvim_command('TcloseAll!')
-- api.nvim_command('Tnew')
-- api.nvim_command('Tnew')
-- api.nvim_command('T1 echo "On Your Marks"')
-- api.nvim_command('T2 echo "Ready Set Go"'

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

--[[
--Place holders
--]]
-- local function onStdOut()
--   print( stdOut)
--   return
-- end

-- local function onStdErr()
--   return
-- end

-- local function onExit( win, placeHolderWindow )
--    -- util.echom( ' - on exit' )
--    api.nvim_win_set_height(win, 7)
--    api.nvim_set_current_win(placeHolderWindow)
--    _M.openInSplitWindow('log')
--   return
-- end

local function getRelativePath( fPath )
  local dProjectPath = api.nvim_call_function('projectionist#path',{})
  --local iProjectPathLength =  string.len(dProjectPath) + 2
  local iProjectPathLength =  api.nvim_strwidth(dProjectPath) +2
  return string.sub( fPath, iProjectPathLength )
end

--[[
Find command in terminal window
--]]
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
        api.nvim_win_set_height(winFound, 10)
      end
    end
  end
  return winFound, buffer
end


--[[
--  Find Buffer name in window
--]]
local function findBufNameInWin( fName )
  local wins = api.nvim_list_wins()
  local winFound
  for i, window in ipairs(wins) do
    local buffer = api.nvim_win_get_buf(window)
    local bufferName = api.nvim_buf_get_name( buffer )
    local fBuf = getRelativePath( bufferName)
    if fBuf == fName then
      winFound = window
      api.nvim_win_set_height(winFound, 10)
      break
    end
  end
 return winFound
end


local function getProjectionValue( projection )
  local arr = {}
  arr[1] = projection
  -- local value, err = pcall(isGlobalVar,'my_placeholder_window')
  local value = api.nvim_call_function('my#project#value',arr)
  if not value  then
    return nil
  end
  -- util.echom( str)
  return value
end

function _M.openInTerminalWindow( projection )
  -- api.nvim_command('DeleteHiddenBuffers')
  local arr = {}
  arr[1] = projection
  local sTermCommand = api.nvim_call_function('my#project#value',arr)
  -- util.echom( type(sTermCommand) )
  if type(sTermCommand) ~= 'string' then
    return
  end
  local oOpts = {
    sTermCommand
  }
  -- util.echom( 'create new window' )
  -- util.echom( ' - execute term command: ' ..  sTermCommand )
  local placeHolderWindow = api.nvim_get_current_win()
  local winFound, buffer = findCmdInTermWin( sTermCommand )
  if winFound then
     util.echom( ' - window: ' .. tostring(winFound))
    -- util.echom( ' - bufferName: ' .. bufferName)
    -- util.echom( ' - buffer: ' .. tostring(buffer))
    api.nvim_set_current_win(winFound)
    api.nvim_set_current_buf(buffer)
    api.nvim_command('bw!')
  end
   -- util.echom( ' - open new window' )
   api.nvim_command('botright 7new term')
  --  api.nvim_win_set_height(api.nvim_get_current_win(), 7)
  -- api.nvim_win_set_height(api.nvim_get_current_win(), 5)
   api.nvim_call_function('termopen',oOpts)
   api.nvim_set_current_win(placeHolderWindow)
   -- local window = api.nvim_get_current_win()
   -- local buffer = api.nvim_get_current_buf()
   -- api.nvim_win_set_height(window, 7)
   -- local iLines = api.nvim_buf_line_count(buffer)
   --  util.echom( iLines )
   -- local iLines = api.nvim_buf_line_count(buffer)
   -- api.nvim_set_cursor(buffer)
    -- ['on_stdout'] = onStdOut(),
   -- ['on_stderr'] = onStdErr(),
   --oOpts['on_exit'] = onExit(api.nvim_get_current_win(),placeHolderWindow)
end
--[[
Display Project Log
--]]
function _M.openInSplitWindow( projection )
  local arr = {}
  arr[1] = projection
  local fLog = api.nvim_call_function('my#project#value',arr)
  local placeHolderWindow = api.nvim_get_current_win()
  local winFound = findBufNameInWin( fLog )
  if winFound then
    --util.echom( ' - use old window' )
    api.nvim_set_current_win(winFound)
    api.nvim_command('Elog')
  else
    -- util.echom( 'create new window' )
    api.nvim_command('Slog')
    api.nvim_win_set_height(api.nvim_get_current_win(), 10)
  end
  api.nvim_set_current_win(placeHolderWindow)
end

function _M.init()
  local placeHolderWindow
  local gvPlaceHolder, err = pcall(isGlobalVar,'my_placeholder_window')
  if not gvPlaceHolder then
    local bvHasProjection, err = pcall(isBufferVar,'projectionist')
    if bvHasProjection then
      placeHolderWindow = api.nvim_get_current_win()
    else
      placeHolderWindow = ''
    end
    api.nvim_set_var('my_placeholder_window',placeHolderWindow)
  end
  -- util.echom( err)
  return
end

function _M.prove()
  local bufHasProjection, err = pcall(isBufferVar,'projectionist')
  if not bufHasProjection then
    return
  end
  local projectionValue =  getProjectionValue('test')
  if not projectionValue['file'] then
    util.echom( 'OH NO!! no test projection for buffer ' )
    return
  else
  -- api.nvim_set_var('my_test_file',projectionValue['file'])
  end
  -- util.echom(  api.nvim_get_var('my_test_file' ))
  local accioDo = projectionValue['do']
   api.nvim_call_function('accio#accio',accioDo)
end

return _M
