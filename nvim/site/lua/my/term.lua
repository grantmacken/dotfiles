local _M = {}

local util = require('my.util')
local fs = require('my.fs')
local log = require('my.log').log
local api = vim.api

function _M.onOpen()
  log(' - on term open')
  log('   ------------')
  local title = api.nvim_buf_get_var(0, 'term_title')
  local jobID = api.nvim_buf_get_var(0, 'terminal_job_id')
  local jobPID = api.nvim_buf_get_var(0, 'terminal_job_pid')
   log(' - title: '  ..  title )
   log(' - jobID: '  ..  jobID )
   log(' - jobPID: ' ..  jobPID )
  api.nvim_win_set_option(0, 'number', false)
  api.nvim_win_set_option(0, 'relativenumber', false)
  api.nvim_win_set_option(0, 'spell', false)
  -- api.nvim_buf_set_option(0, 'modifiable', true)
  api.nvim_buf_set_option(0, 'scrollback', 100000 )
  api.nvim_buf_set_option(0, 'modified', false )
  -- allow closing buffer without warning
  api.nvim_buf_set_option(0, 'bufhidden','wipe')
  --- if not in window wipeout 
  api.nvim_win_set_option(0, 'statusline', title )
  -- scrollback
  -- buffhiden
  -- api.nvim_win_set_option(-0, 'hidden', false)
  -- if not util.isGlobalVar( 'my_jobs' ) then
  --   return
  -- end
  -- local jobWaitOpts = {}
  -- jobWaitOpts[1] = {jobID}
  -- local wait = api.nvim_call_function('jobwait', jobWaitOpts )
  -- log('wait: ' .. tostring( type(wait) ))
  -- log('wait: ' .. tostring( util.isArray(wait) ))
  -- log('wait: ' .. tostring( wait[1] ))
  -- api.nvim_command('caddbuffer ')
 -- parse_quickfix_erro
 -- local oMyJobs = api.nvim_get_var( 'my_jobs' )
 -- local iMyJobsCount = util.isArray( oMyJobs )
 -- log(  ' - session job count: ' .. tostring( iMyJobsCount ))
 -- if  iMyJobsCount > 0 then
 --   local oThisJob = oMyJobs[iMyJobsCount]
 --   log( ' - compiler: '   ..  oThisJob['compiler'] )
 --   local ilineCount = api.nvim_buf_line_count(0)
 --   log( ' - lineCount: '   ..  tostring(ilineCount) )
 --   local lines = api.nvim_buf_get_lines(0,1,ilineCount,1)
 --   for i, line in ipairs(lines) do
 --     log( line )
 --   end
 -- end
 log('--------------------------------')
end

function _M.onResponse(...)
  log(' - on term response')
  local title = api.nvim_buf_get_var(0, 'term_title')
  local jobID = api.nvim_buf_get_var(0, 'terminal_job_id')
  local jobPID = api.nvim_buf_get_var(0, 'terminal_job_pid')
  log(' - title: ' .. title)
  log(' - jobID: ' .. jobID)
  log(' - jobPID: ' .. jobPID)
end

function _M.onClose()
 log(' - on term open')

end

function _M.open()
  local opts = {}
  local cmd = 'ls'
  api.nvim_command('botright 7new')
  api.nvim_command('call termopen("ls",{})')
  -- local sID = api.nvim_call_function('termopen',{})
  
  -- cmd ' if exec on path call by name '
  -- termopen( cmd, opts)
  -- returns job-id
  -- like job-start opts are job handlers
  -- on_stdout
  -- on_stderr
  -- on_exit
  -- cwd
   -- api.nvim_win_set_option(0, 'hidden', false)
end

-- function! my#term#preserve(command)
--   setlocal lazyredraw
--   let l:search=@/

--   let l:last_view = winsaveview()
--   execute a:command
--   call winrestview(l:last_view)

--   let @/=l:search
--   redraw
--   setlocal nolazyredraw
-- endfunction
return _M
