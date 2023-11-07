return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim', 'mrbjarksen/neo-tree-diagnostics.nvim' },
  -- cmd = "Neotree",
  keys = {
    { '-', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  opts = {
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(_)
          require('neo-tree').close_all()
        end,
      },
    },
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    default_source = 'filesystem',
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'diagnostics',
    },
    window = {
      mappings = { ['<space>'] = false },
      position = 'right', -- left, right, float, current
      popup = {
        position = { col = '100%', row = '2' },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ':~')
          local root_len = string.len(root_name) + 4
          return {
            width = math.max(root_len, 50),
            height = vim.o.lines - 6,
          }
        end,
      },
    },
  },
  config = true,
}
