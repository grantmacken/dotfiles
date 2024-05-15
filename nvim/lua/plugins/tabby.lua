local M = {}

-- local util = require('my.util')
-- -- plugin setup config options
-- local config = {
--   view_options = {
--     -- Show files and directories that start with "."
--     show_hidden = true,}
--   }
-- -- plugin leader mappings
-- local mappings = function()
-- -- local  map_leader = util.nmap_leader
--   vim.keymap.set('n', '-', function() vim.cmd.Oil() end, { desc = '[oil] open parent directory' })
-- end

M.setup = function()
  require("tabby.tabline").use_preset("active_wins_at_tail", {
    theme = {
      fill = "TabLineFill",
      head = "TabLine",
      current_tab = "TabLineSel",
      tab = "TabLine",
      win = "TabLine",
      tail = "TabLine",
    },
    nerdfont = true,
    lualine_theme = nil,
    buf_name = {
      mode = "unique",
    }
  })
end

return M
