--TODO For testing remove
local show = require('show')

vim.api.nvim_create_user_command(
  'ShowDataAString',
  function()
    local name = 'bufScratchTest'
    local data = [[
      This is an example output
      that will be shown in a scratch buffer
      with the title 'Example Output
      ]]
    show.data(name, data, { filetype = 'markdown' })
  end,
  { desc = 'An example action that shows output in a scratch buffer' }
)
--
-- vim.api.nvim_create_user_command(
--   'ShowSendString',
--   function()
--     local name = 'bufScratchTestOutut'
--     local data = [[
--       This is an example output
--       that will be shown in a scratch buffer
--       with the title 'Example Output
--       ]]
--     show.send(name, data, { filetype = 'markdown' })
--   end,
--   { desc = 'An example action that shows output in a scratch buffer' }
-- )
--
-- vim.api.nvim_create_user_command(
--   'ShowSendStringAppend',
--   function()
--     local name = 'bufScratchTestOutut'
--     local data = [[
--       This is an example output
--       that will be shown in a scratch buffer
--       with the title 'Example Output
--       ]]
--     show.send(name, data, { append = true })
--   end,
--   { desc = 'An example action that shows output in a scratch buffer' }
-- )
--
-- vim.api.nvim_create_user_command(
--   'ShowSendTable',
--   function()
--     local name = 'bufScratchTestOutut'
--     local data = {
--       "This is an example output",
--       "that will be shown in a scratch buffer",
--       "with the title 'Example Output'",
--     }
--     show.send(name, data)
--   end,
--   { desc = 'An example action that shows output in a scratch buffer' }
-- )
--
-- vim.api.nvim_create_user_command(
--   'ShowEditData',
--   function()
--     local name = 'bufEditTestDataOutut'
--     local data = {
--       "This is an example output",
--       "that will be shown in a normal listed buffer",
--     }
--     show.send(name, data)
--   end,
--   { desc = 'An example action that shows output in a scratch buffer' }
-- )
--
-- vim.api.nvim_create_user_command(
--   'ShowTaskData',
--   function()
--     local name = 'bufTaskTest'
--     local data = {
--       "This is an example output",
--       "that will be shown in a terminal buffer",
--     }
--     show.send(name, data)
--   end,
--   { desc = 'An example action that shows output in a term buffer' }
-- )
--
-- vim.api.nvim_create_user_command(
--   'ShowTaskDataClear',
--   function()
--     local name = 'bufTaskTest'
--     local data = {
--       "This is an example output",
--       "that will be shown in a terminal buffer",
--     }
--     show.send(name, data, { clear = true })
--   end,
--   { desc = 'An example action that shows output in a term buffer' }
-- )

vim.api.nvim_create_user_command(
  'ShowShellCmd',
  function()
    local name = 'bufShellTest'
    local cmd_string = 'ls -l'
    show.run(name, cmd_string)
  end,
  { desc = 'An example action that shows output in a term buffer' }
)
