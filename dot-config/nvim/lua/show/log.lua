local M = {}
M.version = "0.1.0"
M.description = [[
 Internal logging support for the show module family.
 - overview: creates and configures a shared vim.log logger and routes warn/error entries toward Neovim diagnostics
 - scope: owns file-backed logging for show modules; not the public show buffer/window API or user-facing commands
 - usage: internal show modules use this module to create and configure a shared logger instance
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] Create a shared show logger with vim.log.new().
 - [ ] Configure the show logger level and log entry format.
 - [ ] View the show logger output in a dedicated show bufShowLog buffer.
 - [ ] Diagnostics: quickfix Read log entries and create diagnotic warnings and errors, create quickfix list.
 - [ ] Pass the shared logger into show submodules that need internal diagnostics.
]]

M.references = [[
 - https://neovim.io/doc/user/lua.html#vim.log
 - init.lua
 - chan.lua
 - buf.lua
 - util.lua
]]
--- define  vim.log type for documentation purposes
---@class vim.log

---@return table
local create = function()
  -- Create a new logger instance for the show module
  -- leave log.level at default (WARN)
  local name = 'show'
  local path = vim.fs.joinpath(vim.fn.stdpath('log'), 'show.log')
  local oLog = vim.log.new({ name = 'show', })
  return { log = oLog, name = name, path = path }
end

local view = function(path)
  vim.notify(string.format("TODO! Show log file: %s", path), vim.log.levels.INFO)
end

local diagnostics = function(path)
  vim.notify(string.format("TODO! Show log diagnostics for file: %s", path), vim.log.levels.INFO)
end

M.create = create
M.view = view
M.diagnostics = diagnostics
return M
