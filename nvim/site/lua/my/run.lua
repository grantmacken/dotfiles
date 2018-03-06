
--[[
--  develop stuff here
--  run
--  luafile $DATAPATH/lua/my/run.lua
--  turn imto module
--]]

local cjson = require('cjson')
local util = require('my.util')
local jobs = require('my.jobs')
local fs = require('my.fs')
local qf = require('my.qf')
local log = require('my.log').log
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
  -- log( ' - on std out'  )
end

local function onStdErr()
  -- log( ' - on std err'  )
  return
end

local function onExit()
  log( ' - on job exit'  )
  -- log( jobs[1] )
  return
end


local function openTerm()
  log( ' - open term' )
  local oMyJobs = api.nvim_get_var( 'my_jobs' )
  local iMyJobsCount = util.isArray( oMyJobs )
  local oThisJob = oMyJobs[iMyJobsCount]
  log( ' - buffer: ' .. oThisJob['buffer'] )
  log( ' - window: ' .. oThisJob['window'] )
  log( ' - compiler: ' .. oThisJob['compiler'] )
  log( ' - make program: ' ..  oThisJob['makeprg'] )
  log( ' - error format: ' ..  oThisJob['errorformat'] )
  local sTermCommand = oThisJob['makeprg']
  if type(sTermCommand) ~= 'string' then
    return
  end
  local oOpts = {
    sTermCommand,
    ['on_stdout'] = onStdOut(),
    ['on_stderr'] = onStdErr(),
    ['on_exit'] = onExit()
  }
  log( ' - close term windows with same command ')
  local winFound, bufferName, buffer = findCmdInTermWin( sTermCommand )
  if winFound then
    api.nvim_command('close! ' .. winFound )
  end
  log( ' - create small window ')
  api.nvim_command('botright 3new')
  log( ' - run terminal command')
  api.nvim_call_function('termopen',oOpts)
  log( ' - return focus to editing window')
  api.nvim_set_current_win(oThisJob['window'])
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

jobs.initProjectJobs()
jobs.setJobsForBuffer()

log( 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' )
-- get jobs for session
local oMyJobs = api.nvim_get_var( 'my_jobs' )
local iMyJobsCount = util.isArray( oMyJobs )
local oThisJob = oMyJobs[iMyJobsCount]
log( ' - buffer: ' .. oThisJob['buffer'] )
log( ' - window: ' .. oThisJob['window'] )
log( ' - compiler: ' .. oThisJob['compiler'] )
log( ' - make program: ' ..  oThisJob['makeprg'] )
log( ' - error format: ' ..  oThisJob['errorformat'] )

-- clear qflist-
-- qflist title
local qfTitle = {}
qfTitle['title'] = 'my compiler job'
log( 'global errorformat: ' .. api.nvim_get_option('errorformat'))
log( 'global makeprg: ' .. api.nvim_get_option('makeprg'))

api.nvim_set_option('errorformat',oThisJob['errorformat'])
api.nvim_call_function('setqflist',{{},'r',qfTitle})
--api.nvim_command('compiler ' .. oThisJob['compiler'])
local jobID =  api.nvim_call_function('my#jobs#job',{oThisJob['makeprg']})
 -- local jobID =  api.nvim_call_function('my#jobs#job',{'ls'})
log( 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' )

-- api.nvim_set_var('errorformat',oThisJob['errorformat'])
-- log(api.nvim_get_var('errorformat'))

--
--
  
-- local txt = 'lualib/grantmacken/util.lua:182:I: [ acceptContentTypes() ] the content types this endpoint can handle'

-- local jobWaitOpts = {}
  -- jobWaitOpts[1] = {jobID}
  -- local wait = api.nvim_call_function('jobwait', jobWaitOpts )



-- local sTermCommand = 'ls'
-- local oOpts = {
--     sTermCommand,
--     ['on_stdout'] = onStdOut( id, data, event),
--     ['on_stderr'] = onStdErr(...),
--     ['on_exit'] = onExit(...)
--   }

-- local jobID =  api.nvim_call_function('termopen', oOpts)

-- log( ' - quicklist items'  )
-- empty dictionary
-- local qflist =  api.nvim_call_function('getqflist',{})
--   log( ' - type: '   ..  type(qflist) )
--   log( ' -  count: ' ..  tostring(util.isArray(qflist)))
-- -- for i, err in ipairs(qflist) do
-- --   log( ' -  ' ..  util.listKeys(err))
-- --   log( ' - type: '   ..  err['type'] )
-- --   log( ' - buffer: ' ..  err['bufnr'] )
-- --   log( ' - line: ' ..  err['lnum'] )
-- --   log( ' - column: ' ..  err['col'] )
-- --   log( ' - text: '   ..  err['text'] )
-- -- end
-- log( ' -----------------------------------------  ' )


 -- local qfHistory = api.nvim_command('chistory')
-- local qfHistory =  api.nvim_call_function('chistory',{})
--   log( type(qfHistory) )
-- local wins = api.nvim_list_wins()
-- local winFound
-- local buffer
-- local bufferName
-- for i, window in ipairs(wins) do
--   buffer = api.nvim_win_get_buf(window)
--   local bufferType = api.nvim_buf_get_option( buffer, 'buftype' )
--   bufferName = api.nvim_buf_get_name( buffer )
--   if bufferType == 'terminal' then
--     local nameFound = string.find( bufferName, sCmd )
--     if nameFound ~= nil then
--       winFound = window
--     end
--   end
-- end


