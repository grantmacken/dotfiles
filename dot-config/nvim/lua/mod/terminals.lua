M = {}
-- local api = vim.api
-- local tab_nr     = api.nvim_get_current_tabpage()
-- local win_nr     = api.nvim_get_current_win()
-- local buf_nr     = api.nvim_get_current_buf()
-- local line_nr    = api.nvim_get_current_line()
--M.setup = function()

--end
M.run = function()
  local api  = vim.api
  local tabpage  = api.nvim_get_current_tabpage()
  local win     = api.nvim_get_current_win()
  local buf     = api.nvim_get_current_buf()
  local line    = api.nvim_get_current_line()
  --[[
  One terminal for a tabpage
  ]]--
 local ok , termTab, _ =  pcall(api.nvim_tabpage_get_var,tabpage,'term_tabpage')
  if ok then
   -- api.nvim_tabpage_set_var(tabpage,'term_tabpage' tabpage)
   -- local tabpage_wins = api.nvim_tabpage_list_wins(tabpage)
   -- vim.cmd('hide'):qa
   vim.print(termTab)
  else -- no term_tabpage
    local split_direction = 'below'--: "left", "right", "above", "below"
    local enter = true
    local term_buf = api.nvim_create_buf(false, false)
    --print(term_buf)
    local term_win = api.nvim_open_win(term_buf, false ,{split = split_direction,height=20, win = api.nvim_get_current_win()})
    --vim.cmd([[ botright sp | term ]])
    local chan = api.nvim_open_term( term_buf,{})
    api.nvim_chan_send(chan, 'hi')

  end
end

local chromeTermWin = function(winID)
    vim.wo[winID].number = false
    vim.wo[winID].relativenumber = false
    vim.wo[winID].statuscolumn = ""
    vim.wo[winID].signcolumn = "no"
    vim.wo[winID].spell = false
end

local openTermWin = function(tabpage,bufnr)
    local enter = false
    local split_direction = 'below'--: "left", "right", "above", "below"
    local winID = vim.api.nvim_open_win(bufnr, enter ,{split = split_direction})
    chromeTermWin(winID)
    --Move the current window to be at the very bottom, using the fullwidth of the screen.  This works like `:topleft split`, except
    vim.api.nvim_win_call(winID,function() vim.cmd('wincmd J') end)
    vim.api.nvim_tabpage_set_var(tabpage,'termID',bufnr)
    vim.api.nvim_tabpage_set_var(tabpage,'winID',winID)
end

M.toggle = function()
--[[
create a terminal buffer but do not enter
--]]
  local api  = vim.api
  local tabpage  = api.nvim_get_current_tabpage()
  local window     = api.nvim_get_current_win()
  local buf     = api.nvim_get_current_buf()
  local line    = api.nvim_get_current_line()
  local cursor_pos  = api.nvim_win_get_cursor(window)
  --[[
  One terminal for a tabpage
  ]]--
 local ok , termWinID, _ =  pcall(api.nvim_tabpage_get_var,tabpage,'termID')
  if ok then
    --vim.print(api.nvim_tabpage_list_wins(termTab))
   -- api.nvim_tabpage_set_var(tabpage,'term_tabpage' tabpage)
   -- local tabpage_wins = api.nvim_tabpage_list_wins(tabpage)
   -- vim.cmd('hide')
   local bufnr = api.nvim_tabpage_get_var(tabpage,'termID')
   local winID = api.nvim_tabpage_get_var(tabpage,'winID')
   local hasTermWin = api.nvim_win_is_valid(winID)
   local hasTermBuf = api.nvim_buf_is_valid(bufnr)
   if hasTermWin then
      api.nvim_win_hide(winID)
     --vim.print(api.nvim_win_is_valid(winID))z
   else
    openTermWin(tabpage,bufnr)
   end
  else -- no term_tabpage
    --nvim_tabpage_list_wins({tabpage})
    local bufnr = api.nvim_create_buf(false, false)
    vim.bo[bufnr].filetype = "Term"
    -- we are not entering the buffer
    api.nvim_buf_call(bufnr,  function() 
      vim.cmd('term')

    end)
    -- api.nvim_buf_set_name(bufnr, 'Terminal for tabpage: ' .. tabpage)
    api.nvim_create_autocmd("BufEnter", {
        buffer = bufnr,
        callback = function()
          vim.defer_fn(function()
            vim.cmd.startinsert({ bang = true })
            vim.cmd("noh")
          end, 100)
            --vim.cmd.startinsert
        end,
    })
    openTermWin(tabpage, bufnr)
   end
  -- reset cursor
  api.nvim_win_set_cursor(window,cursor_pos)
end

return M
--print(vim.g.myTermID)
