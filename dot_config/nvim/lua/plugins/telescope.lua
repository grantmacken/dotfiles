return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension 'fzf'
      end,
    },
  },
  cmd = 'Telescope',
  opts = {
    defaults = {
      prompt_prefix = string.format('%s ', require('my.icons').ui.search),
      selection_caret = string.format('%s ', require('my.icons').ui.select),
      path_display = { 'truncate' },
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
    },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)
  end,
}
