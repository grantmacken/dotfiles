local _M = {}

local util = require('my.util')
local log = require('my.log').log
local api = vim.api

--[[
-- :NvimAPI
-- :h api
-- :h lua
--]]


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
  -- log( ' - get projection value: ' .. projection )
  local arr = {}
  arr[1] = projection
  -- local value, err = pcall(isGlobalVar,'my_placeholder_window')
  local value, err = pcall(api.nvim_call_function,'my#project#value',arr)
  if not value then
    log( '[ERR] ' ..  err )
    return nil
  end
  return api.nvim_call_function('my#project#value',arr)
end

_M.getProjectionValue = getProjectionValue

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

function _M.detect()
  -- log( ' -  searching for projections'  )
  return
end

function _M.activate()
  log( ' - projection activated'  )
  local buffer = api.nvim_get_current_buf()
  --local bufHasProjection, err = pcall(isBufferVar,'projectionist')
  local value, err = pcall(api.nvim_buf_get_var, buffer,'projectionist_file')
  if not value then
    log('[ERR] ' .. err )
    return
  end
  local bufferName = api.nvim_buf_get_name( buffer )
  -- log( ' - bufferName: ' .. getRelativePath(bufferName) )
  api.nvim_buf_set_var( buffer, 'my_test_file', getTestFile(buffer) )
  -- log( ' - has projectionist file: ' .. tostring(value) )
  -- log( ' - file: ' .. getRelativePath(api.nvim_buf_get_var( buffer,'projectionist_file')))
   --log( ' -----------------------------------------  ' )
  return
end


function getTestFile( buffer )
  -- log( ' - get test file'  )
  local sTest =  getProjectionValue('test')
  local sType =  getProjectionValue('type')
  -- local sAlternate =  getProjectionValue('alternate')
  -- log( ' -  ' .. tostring( sTest) )
  -- log( ' -  ' .. tostring( sType) )
  -- log( ' -  ' .. tostring( sAlternate) )
  if sType ~= 'test' then
    return getProjectionValue('alternate')
  else
    return getRelativePath(api.nvim_buf_get_var( buffer,'projectionist_file'))
  end
end

function _M.prove()
  ----log( ' - projection prove'  )
  --local buffer = api.nvim_get_current_buf()
  ---- local fCurBuf = getRelativePath(api.nvim_buf_get_var( buffer,'projectionist_file'))
  --local fTest =  getTestFile(buffer)
  --local oTest =  getProjectionValue('test')
  --api.nvim_buf_set_var( buffer, 'my_test_file' ,fTest )
  --api.nvim_call_function('accio#accio',oTest)
end

return _M
