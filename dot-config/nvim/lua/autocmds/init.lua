local M = {}

-- local split_words = require('util').split_words
-- local build_description = require('util').build_description
-- local build_fun_name = require('util').build_fun_name

--[[ help
nvim_create_autocmd()
autocmd
autocmd-events
autocmd-patterns
autocmd-buflocal
nvim_create_augroup()
nvim_create_autocmd()
nvim_del_augroup_by_id()
nvim_del_augroup_by_name()
nvim_del_autocmd()
nvim_get_autocmds()
nvim_get_autocmds_by_event()
nvim_get_autocmds_by_group()
nvim_get_autocmds_by_pattern()
nvim_get_autocmds_by_buffer()
--]]
--
--[[ set_callbacks
 event: the event to trigger the autocmd
 opts: a table of options for the autocmd, including:
- group: `name` the augroup to add the autocmd to
• command `string` Vim command executed on event. Not allowed with {callback}.
- once: `boolean` If true, the autocommand will be removed after being executed once.
--]]

--- autocmds a list of field-value tables with the following fields event, pattern, group, callback, desc
---@param autocmds table[] a list of autocmd definitions, where each autocmd is a table with table fields { event, pattern, group, callback }
---@return nil
M.set_callbacks = function(autocmds)
  for _, autocmd in ipairs(autocmds) do
    vim.api.nvim_create_autocmd(autocmd.event, {
      group = autocmd.group,
      pattern = autocmd.pattern,
      callback = autocmd.callback,
    })
  end
end

--@param autocmds table[] a list of tables with each containing the following fields { event, command, group, once }
--@param bufnr? integer the buffer number to set the commands for: zero will be the current buffer
M.set_cmds = function(autocmds, bufnr)
  for _, au in ipairs(autocmds) do
    vim.api.nvim_create_autocmd(au.event, {
      buf = bufnr or 0,
      command = au.command,
      group = au.group or 'custom-cmd-group',
      once = au.once or false,
    })
  end
end


--[[ autocmds a list of field-value tables with the following fields:
-- event, pattern, group, name
 name is the function name in the luamodule
--]]
-- ---@param autocmds table the list of field-value tables
-- ---@param module table module function table
-- ---@return nil
-- M.set_mod_callbacks = function(autocmds, module )
--   for _, au in ipairs(autocmds) do
--     -- guard: module must exist and have the function to call
--     local fun_name = au.fun_name
--     local event = au.event
--     local group = au.group
--     if module and type(module) == "table" and module[fun_name] then
--       vim.api.nvim_create_autocmd(event, {
--           group = group,
--           pattern = event,
--           callback = module[fun_name]
--         })
--       end
--     end
-- end
--
--[[ set_cmds
decription: events to invoke vim buf_local cmdline commands

event { opts}
 event: the event to trigger the autocmd
 opts: a table of options for the autocmd, including:
- group: `name` the augroup to add the autocmd to
- buf: `integer` Buffer id for buffer-local autocommands |autocmd-buflocal|. Not allowed with {pattern}.
• command `string` Vim command executed on event. Not allowed with {callback}.
- once: `boolean` If true, the autocommand will be removed after being executed once.

With this pattern
we can create a lua list table []
each list item contains field-value table with the following fields
 - event
 - group
 - command
 - once

local group =
local cmds_list = {
  {
    event = 'BufWritePost',
    group = 'my_group',
    command = 'echo "Buffer written!"',
    once = false,
  }}

require('autocmds').set_cmds(cmds_list,bufnr)
--]]


return M
