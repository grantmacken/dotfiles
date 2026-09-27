local M = {}
M.version = "0.1.0"
M.description = [[
 Parse and resolve structured Neovim command names into module functions.
 - overview: splits command names, builds descriptions, and resolves functions from root or submodules
 - scope: owns command-name parsing and module-function lookup; registration belongs to commands, keymaps, and plugin files
 - usage: commands.set() and keymaps.set() call get_func_and_desc(cmd, mod?) for command resolution and descriptions
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [x] Parse structured command names and generate human-readable descriptions.
 - [x] Resolve functions from root modules and optional submodules for command consumers.
]]

M.references = [[
 - ../../plugin/10_user_commands.lua
 - ../../plugin/11_keymaps.lua
 - ../commands/init.lua
 - ../keymaps/init.lua
]]

--- Split a command name into words, using camel case and separators as delimiters.
---@param cmd string
---@return string[]|nil
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

--- Build a description from the words, by joining them with spaces and lowercasing them.
---@param words string[]
---@return string
M.description = function(words)
  return vim.iter(words):map(function(sWord) return sWord:lower() end):join(" ")
end

---@param  words string[]
---@param mod? string
---@return table|nil
local get_module = function(words, mod)
  if mod then
    local ok, module = pcall(require, words[1]:lower() .. "." .. mod)
    if ok then
      return module
    else
      vim.notify(string.format("Module '%s.%s' not found", words[1], mod), vim.log.levels.WARN)
      return nil
    end
  else
    local ok, module = pcall(require, words[1]:lower())
    if ok then
      return module
    else
      vim.notify(string.format("Module '%s' not found", words[1]), vim.log.levels.WARN)
      return nil
    end
  end
end

--[[
 a cmd like string "RepoIssueView' is split into words {"Repo", "Issue", "View"}
  and then the first word is used to require a module, and the rest of the words are used to call a function in that module.
  The function name is constructed by joining the rest of the words together, with the first word lowercased and the rest of the words unchanged.
  For example, if the cmd is "RepoIssueView", require("repo") is the module,
  and the function 'issueView' is callable in that module.
  however ..,
  If the optional `mod` parameter is provided, it will be used to require the module.
  get_func_and_desc(IssueView, repo)  require("repo.issue) is the module,
  and the function 'view' is called in that module.
  This is useful for commands that are not in the root module, but in a submodule.
  Mainly used for buffer local commands, in a show window
--]]

---@param cmd string
---@param mod? string
---@return function|nil, string
M.get_func_and_desc = function(cmd, mod)
  local words = M.split_words(cmd)
  if not words then
    return nil, string.format("No words found in command '%s'", cmd)
  end
  -- the first word should return a handle of the module
  local module = get_module(words, mod)
  if not module then
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
  if module[fun_name] and type(module[fun_name]) == "function" then
    return module[fun_name], desc
  else
    return nil, string.format("Function '%s' not found in module '%s'", fun_name, words[1])
  end
end

return M
