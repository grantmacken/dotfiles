local M = {}
M.version = "0.1.0"
M.description = [[
 A brief plan outline of what the module will achieve.
 - overview: module overview which describes the module's purpose and functionality
 - scope: module scope
 - usage: how to use the module
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] todo task 1
 - [ ] todo task 3
]]

M.references = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

M.commitFile = function()
  -- Commit the current file with a message provided by the user
  vim.ui.input({ prompt = 'Enter commit message: ' }, function(input)
    if input then
      vim.cmd([[!git commit % -m "]] .. input .. [["]])
    else
      vim.notify("Commit message is required", vim.log.levels.ERROR)
    end
  end)
end

-- put output of git status into quickfix list, with the status as the text and the filename as the filename
M.statusToQuickfix = function()
  -- Fetch the array of modified lines from the shell execution
  local lines = vim.fn.systemlist("git status --short")
  local qf_entries = {}

  for _, line in ipairs(lines) do
    -- 'git status -s' prints entries like: ' M src/main.lua' or '?? notes.txt'
    local status = line:sub(1, 2)
    local filename = line:sub(4) -- Extract string path starting after status flags

    if filename ~= "" then
      table.insert(qf_entries, {
        filename = filename,
        text = "Git [" .. status:gsub("%s+", "") .. "]", -- Cleans trailing whitespace flags
        lnum = 1,                                        -- Defaults your cursor position to line 1
      })
    end
  end
  -- Feed the structured items into the quickfix processor
  if #qf_entries > 0 then
    vim.fn.setqflist(qf_entries, 'r') -- 'r' replaces the current list context
    vim.cmd('copen')                  -- Instantly brings up the quickfix tray
  else
    vim.notify("Git working directory is clean.", vim.log.levels.INFO)
  end
end

return M
