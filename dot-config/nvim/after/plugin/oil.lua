local ok, oil = pcall(require,'oil')
if not ok then vim.notify('no oil') return end
oil.setup({
    columns = {
    "icon",
  },
  skip_confirm_for_simple_edits = true,
  view_options = {show_hidden = true},
})
local nMap = require('keymaps').nMap
nMap('-', function() vim.cmd.Oil() end,  '[oil] open parent directory')
