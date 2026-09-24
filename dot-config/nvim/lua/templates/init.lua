local M = {}
M.version = "0.1.0"
M.description = [[
 template module
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

local create_lua_module_file = function(module_name)
  local mod_dir = vim.fs.joinpath(vim.fn.stdpath("config"), 'lua', module_name)
  vim.fs.mkdir(mod_dir, { parents = true }) -- Create the directory if it doesn't exist
  local full_path = vim.fs.joinpath(mod_dir, "init.lua")
  vim.cmd.edit(full_path)                   -- Open the new module file in a new buffer
end

M.createLuaModule = function()
  --  input the module name from vim.input, and create a new lua module file in the lua directory of the nvim config
  vim.ui.input({ prompt = 'Enter module name: ' }, function(input)
    if input then
      create_lua_module_file(input)
    else
      vim.notify("Module name is required", vim.log.levels.ERROR)
    end
  end)
end

--
-- M.createLuaModule = function(args)
--   local path = vim.fs.joinpath(
--     vim.fn.stdpath("config"),
--     "templates",
--     'lua_module.' .. vim.fs.ext(args.file)
--   )
--   if vim.uv.fs_stat(path) then
--     vim.cmd("0r " .. path)
--   end
-- end
--

return M
