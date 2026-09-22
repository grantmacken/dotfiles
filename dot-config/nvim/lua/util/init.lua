local M = {}
M.version = "0.1.0"
M.description = [[
 Utility Functions
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

local show = require('show')

M.nvimServerList = function()
  -- Returns a list of server addresses, or empty if all servers
  --[[ serverlist is a list of server addresses: example
{ {
    active = 1.790043563703e+18,
    addr = "/run/user/1000/nvim/dotfiles.sock",
    own = true,
    pid = 12481
  } }
  } }
--]]

  local server_info = vim.fn.serverlist({ info = true })

  -- Calculate max widths for each column (minimum width based on header length)
  local max_addr = 4 -- "Addr"
  local max_pid = 3  -- "PID"
  local max_own = 3  -- "Own"

  vim.iter(server_info):each(function(t)
    max_addr = math.max(max_addr, string.len(t.addr))
    max_pid = math.max(max_pid, string.len(tostring(t.pid)))
    max_own = math.max(max_own, string.len(tostring(t.own)))
  end)

  -- Build the table header and separator using dynamic widths
  local markdown_table = {
    string.format("| %-" .. max_addr .. "s | %-" .. max_pid .. "s | %-" .. max_own .. "s |", "Addr", "PID", "Own"),
    string.format("|-%s-|-%s-|-%s-|", string.rep("-", max_addr), string.rep("-", max_pid), string.rep("-", max_own))
  }

  -- Build the rows using dynamic widths

  -- Build the rows using dynamic widths
  vim.iter(server_info):each(function(t)
    table.insert(markdown_table,
      string.format("| %-" .. max_addr .. "s | %-" .. max_pid .. "d | %-" .. max_own .. "s |", t.addr, t.pid,
        tostring(t.own)))
  end)

  local name = 'bufScratchServerList'
  show.data(name, markdown_table, { filetype = 'markdown' })
end

M.saveAndQuit = function()
  --TODO. mksession
  vim.cmd('wqall')
end

M.split_words = function(cmd)
  local lpeg = require("lpeg")
  local lower = lpeg.R("az")
  local upper = lpeg.R("AZ")
  local digit = lpeg.R("09")
  local separator = lpeg.S(" _-")
  local word = lpeg.C((upper * lower ^ 0) + (lower ^ 1) + (digit ^ 1))
  local split_camel = lpeg.Ct((separator ^ 1 + word) ^ 0)
  local words = split_camel:match(cmd)
  if words and #words > 0 then
    return words
  else
    vim.notify(string.format("No words found in command '%s'", cmd), vim.log.levels.WARN)
    return nil
  end
end

M.description = function(words)
  return vim.iter(words):map(function(sWord) return sWord:lower() end):join(" ")
end

---@param  words string[]
---@return table|nil
M.module = function(words)
  local ok, mod = pcall(require, words[1]:lower())
  if ok then
    return mod
  else
    vim.notify(string.format("Module '%s' not found", words[1]), vim.log.levels.WARN)
    return nil
  end
end

--[[
 a cmd like string "RepoIssueView' is split into words {"Repo", "Issue", "View"}
  and then the first word is used to require a module, and the rest of the words are used to call a function in that module.
  The function name is constructed by joining the rest of the words together, with the first word lowercased and the rest of the words unchanged.
  For example, if the cmd is "RepoIssueView",
  it will resolve module "repo"
  and resolve function "issueView" in that module.
--]]

---@param cmd string
---@return function|nil, string
M.get_func_and_desc = function(cmd)
  local words = M.split_words(cmd)
  if not words then
    return nil, string.format("No words found in command '%s'", cmd)
  end
  -- the first word should return a handle of the module
  local mod = M.module(words)
  if not mod then
    return nil, string.format("Module '%s' not found", words[1])
  end
  -- A description can be build from the words.
  local desc = M.description(words)
  -- a function name is constructed by joining the rest of the words together, with the first word lowercased and the rest of the words unchanged.
  local fun_name = vim.iter(words)
      :skip(1)
      :enumerate()
      :map(function(index, sWord)
        if index == 1 then
          return sWord:lower()
        end
        return sWord
      end)
      :join("")
  -- check if the function exists in the module
  -- return the function if it exists, otherwise return nil
  if mod[fun_name] and type(mod[fun_name]) == "function" then
    return mod[fun_name], desc
  else
    return nil, string.format("Function '%s' not found in module '%s'", fun_name, words[1])
  end
end

return M
