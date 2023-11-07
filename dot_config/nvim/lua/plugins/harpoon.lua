return {
  'ThePrimeagen/harpoon',
  dependencies = {'nvim-lua/plenary.nvim'},
  opts =  {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    global_settings = {
      save_on_toggle = false,
      save_on_change = true,
      enter_on_sendcmd = true,
      excluded_filetypes = { 'harpoon' },
    },
    projects = {},
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon.setup(opts)
local km = vim.api.nvim_set_keymap
km('n', '<leader>ha', [[<cmd>lua require("harpoon.mark").add_file()<CR>]], {desc = 'add marked file'})
km('n', '<leader>hn', [[<cmd>lua require("harpoon.ui").nav_next()<CR>]], {desc = 'next marked file'})
km('n', '<leader>hp', [[<cmd>lua require("harpoon.ui").nav_prev()<CR>]], {desc = 'previous marked file'})
km('n', '<leader>hu', [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], {desc = 'toggle ui menu'})
  end,
}
