--[[
Autocommands:
Initial autocommands
 - create group
 - create list of either
  callback items  and use set_callback
  or
  command item and use set_cmds
 Note: use commands  dot-config/nvim/plugin/10_user_commands.lua
--]]
local group, callbacks
group = vim.api.nvim_create_augroup("group_cmdline", { clear = true })
callbacks = {
  {
    event = "CmdlineChanged",
    pattern = { ":", "/", "?" },
    group = group,
    callback = function() vim.fn.wildtrigger() end,
  },
}
require('autocmds').set_callbacks(callbacks)



-- group = vim.api.nvim_create_augroup("group_templates", { clear = true })
-- callbacks = {
--   {
--     event = "BufNewFile",
--     pattern = "*/lua/*/*.lua",
--     group = group,
--     name = 'createLuaModule'
--   },
--  }
--
-- require('autocmds').set_mod_callbacks(callbacks,'templates')

-- {
--   event = "BufNewFile",
--   pattern = "*/.github/*/SKILL.md",
--   group = group,
--   callback = function(args)
--     vim.notify("Inserting template for new file: " .. args.file, vim.log.levels.INFO)
--     local path = vim.fs.joinpath(
--       vim.fn.stdpath("config"),
--       "templates",
--       vim.fs.basename(args.file)
--     )
--     vim.notify("Template path: " .. path, vim.log.levels.INFO)
--     vim.notify(vim.fs.dirname(args.file), vim.log.levels.INFO)
--     vim.fs.mkdir(vim.fs.dirname(args.file))
--     local dir_as_name = vim.fs.basename(vim.fs.dirname(args.file))
--     if vim.uv.fs_stat(path) then
--       vim.cmd("0r " .. path)
--       --   -- in the yaml front matter, replace the placeholder with the actual filename
--       vim.cmd(":%s/{SKILL_NAME}/" .. dir_as_name .. "/g")
--       vim.cmd.write({ args.file, bang = true })
--     end
--   end,
-- }
