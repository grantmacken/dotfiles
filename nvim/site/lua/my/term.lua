local _M = {}

local api = vim.api

function _M.options()
   local title = api.nvim_buf_get_var(0, 'term_title')
   local jobID = api.nvim_buf_get_var(0, 'terminal_job_id')
   local jobPID = api.nvim_buf_get_var(0, 'terminal_job_pid')
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
