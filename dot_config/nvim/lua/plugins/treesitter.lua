
    -- playground = {
    --   enable = true,
    --   disable = {},
    --   updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    --   persist_queries = false, -- Whether the query persists across vim sessions
    --   keybindings = {
    --     toggle_query_editor = 'o',
    --     toggle_hl_groups = 'i',
    --     toggle_injected_languages = 't',
    --     toggle_anonymous_nodes = 'a',
    --     toggle_language_display = 'I',
    --     focus_language = 'f',
    --     unfocus_language = 'F',
    --     update = 'R',
    --     goto_node = '<cr>',
    --     show_help = '?',
    --   },
    -- },
    --
    --
  -- init = function()
  --   require('nvim-treesitter.install').prefer_git = true
  --   local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  --   parser_config.xquery = {
  --     install_info = {
  --       url = '~/projects/grantmacken/tree-sitter-xquery',
  --       files = { 'src/parser.c' },
  --       branch = 'main',
  --     },
  --     filetype = 'xquery',
  --   }
  -- end,
  --
    --indent = { enable = true },
    --context_commentstring = { enable = true, enable_autocmd = false },  --
return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects', -- TODO
    'HiPhish/nvim-ts-rainbow2',
    'andymass/vim-matchup',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
      additional_vim_regex_highlighting = false,
    },
    ensure_installed = {
      'awk',
      'bash',
      'comment',
      'css',
      'gitignore',
      'gleam',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'html',
      'javascript',
      'jq',
      'json',
      'ledger',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'ocaml',
      'ocaml_interface',
      'ocamllex',
      'query',
      'regex',
      'rust',
      'toml',
      'xml'
    },
    sync_install = false,
    auto_install = false,
    autotag = { enable = false },
    playground = { enable = true},
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = true
      },
    },


    -- query_linter = {
    --   enable = true,
    --   use_virtual_text = true,
    --   lint_events = { 'BufWrite', 'CursorHold' },
    -- },
    -- rainbow = {
    --   enable = true,
    -- },
    -- matchup = {
    --   enable = true, -- mandatory
    -- },
  config = function(_, opts)
    require'nvim-treesitter.configs'.setup(opts)
  end
  }


