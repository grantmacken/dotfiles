local M = {}
M.version = "0.1.0"
M.description = [[
A nvim lua module to manage my GitHub repos
- Provides commands to create, view, and manage GitHub issues and PRs
- Integrates with the GitHub CLI (`gh`) to perform operations
- Uses the `show` module to display issue and PR details in a dedica
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

local async = vim.async
local show = require('show')

--- helper function to get the title and body of an issue or pull request using the GitHub CLI
--- @param what string the type of item to fetch, either "issue" or "pr"
--- @param int number the number of the issue or pull request to fetch
--- @return table a list of lines containing the title and body of the issue or pull request
local get_remote_view_data = function(what, int)
  local data = {}
  local title = vim.fn.systemlist('gh ' .. what .. ' view ' .. tostring(int) .. ' --json title --template {{.title}}')
  vim.list_extend(data, title)
  -- the title is the first line of the buffer, and the body is everything after the first line
  -- add a blank line between the title and the body for better readability
  table.insert(data, '') -- add a blank line between title and body
  local body = vim.fn.systemlist('gh ' .. what .. ' view ' .. tostring(int) .. ' --json body --template {{.body}}')
  vim.list_extend(data, body)
  return data
end

---@param what string the type of item to edit, either "issue" or "pr"
---@param int number the number of the issue or pull request to edit
---@param title string the new title of the issue or pull request
---@param body string the new body of the issue or pull request
---@return boolean, string true if the edit was successful, false otherwise and a notify or error message
M.edit_remote_view = function(what, int, title, body)
  local cmd = { 'gh', what, 'edit', tostring(int), '--title', title, '--body', body }
  local obj = vim.system(cmd):wait()
  if obj.code ~= 0 then
    return false, string.format('Error saving %s: %s', what, obj.stderr)
  end
  return true, string.format('%s #%d remote update successfully', what, int)
end

--[[ issue.list() will display a list of issues in a show window,
with the issue number and title displayed on each line.
With the issue list, you can
  - view an issue by pressing enter on the line with the issue number,
  - or to delete an issue by pressing `del` on the line with the issue number,
  - or to close an issue by pressing `end` on the line with the issue number, etc.

  ]] --

M.issueList = function()
  local cmd = { 'gh', 'issue', 'list', '--limit', '10', '--json', 'number,title' }
  local obj = vim.system(cmd):wait()
  if obj.code ~= 0 then
    vim.notify('Error fetching issues: ' .. obj.stderr, vim.log.levels.ERROR)
    return
  end
  local issues = vim.fn.json_decode(obj.stdout)
  local items = {}
  for _, issue in ipairs(issues) do
    table.insert(items, string.format('#%d %s', issue.number, issue.title))
  end
  local bufnr = show.data('bufScratchRepoIssues', items)
  if bufnr == 0 then
    vim.notify('Error creating issue list buffer', vim.log.levels.ERROR)
    return
  end
  -- set the buffer-local commands for the issue list buffer
  --[[
  require('commands').set({
    'IssueView',   -- view
    'IssueDelete', -- delete
    'IssueCreate', -- create
    -- 'IssueDevelop',     -- develop: create a branch from the issue
    -- 'IssueDevelopList', -- list developing branches for the issue
  }, M, bufnr)
  require('keymaps').set({
    { 'n', '<INS>', '<cmd>IssueCreate<cr>', 'Create new issue' },
    { 'n', '<CR>',  '<cmd>IssueView<cr>',   'View selected issue' },
    { 'n', '<DEL>', '<cmd>IssueDelete<cr>', 'Delete selected issue' },
  }, bufnr)
  -- autocmds table[] a list of autocmd definitions, where each autocmd is a list table with the format { event, command, desc, group, once }
  local group = vim.api.nvim_create_augroup('bufList', {})
  local int = vim.api.nvim_create_namespace('nsNumber')
  vim.api.nvim_set_hl(0, "IssueId", { fg = "#ffd75f", bold = true })
  require('autocmds').bufLocalCmds({
    { 'bufEnter', 'setlocal cursorline',   'cursorline highlight', group, true },
    { 'BufEnter', 'setlocal filetype txt', 'text filetype',        group, true },
    -- { 'BufEnter', [[setlocal syntax match IssueId /#[0-9]\+/]], 'syntax',               group, true },
  }, bufnr)
  --]]
end





-- local user_name = function()
--   local cmd = { 'git', 'config', 'user.name' }
--   local obj = vim.system(cmd):wait()
--   if obj.code == 0 then
--     vim.notify("Git user name: " .. vim.trim(obj.stdout), vim.log.levels.INFO)
--     return vim.trim(obj.stdout)
--   else
--     vim.notify("Error getting git user name: " .. obj.stderr, vim.log.levels.ERROR)
--     return nil
--   end
-- end

--[[
-- display a list of issues in a show window,
-- with the issue number and title, and allow the user to select an issue to view, edit, or delete

]]
---@return nil
M.issueList = function()
  require('repo.issue').list()
end

return M.getGitUserName()
