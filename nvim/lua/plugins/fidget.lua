-- print(vim.inspect(require("fidget.notification").default_config))

local M = {}

M.setup = function()
  require('fidget').setup({
    -- Options related to LSP progress subsystem
    progress = {
      ignore_done_already = true, -- Ignore new tasks that are already complete
      -- Options related to how LSP progress messages are displayed as notifications
      display = {
        render_limit = 3, -- How many LSP messages to show at once
      },
    },
    notification = {
      override_vim_notify = true,
    },
  })
-- vim.notify = require("fidget")
end

return M
