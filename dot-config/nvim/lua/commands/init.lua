local M = {}
M.version = "0.1.0"
M.description = [[
Command conventions: begin with a module name: `repo` with first letter uppercase, then more context: e.g. "RepoIssueCreate"
   - the function to call is the substring after "Repo", with the first letter of the second word lowercased e.g. "RepoIssueCreate" -> "issueCreate"
   - the description for the command is the cmd split into words, e.g. "RepoIssueCreate" -> "Repo Issue Create"
   - the command module can register commands for a provided module table
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

local util = require("util")

---@param commands string[] list of command names
---@param bufnr number|nil optional buffer number to register the commands for
M.set = function(commands, bufnr)
  for _, cmd in ipairs(commands) do
    local func, description = util.get_func_and_desc(cmd)
    if not func then
      vim.notify(string.format("User Commands: no function found for command '%s'", description), vim.log.levels.WARN)
    else
      if not bufnr then
        vim.api.nvim_create_user_command(cmd, function(opts) func(opts) end, { desc = description })
      else
        vim.api.nvim_buf_create_user_command(bufnr, cmd, function(opts) func(opts) end,
          { desc = description })
      end
    end
  end
end

return M
