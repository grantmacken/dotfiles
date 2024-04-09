-- for _, disable in ipairs({ "gzip", "netrwPlugin", "tarPlugin", "zipPlugin" }) do
--   vim.g["loaded_" .. disable] = 0
-- end
for _, provider in ipairs({ "perl", "ruby", "node", "python3" }) do
  vim.g["loaded_" .. provider .. '_provider'] = 0
end
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end
-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
--[[ SETTINGS AND MAPPINGS
 - options
 - autocommands
 - key binds
]]
--
now(function()
  -- setup options, autocommands, etc
  require('core')
end)
--[[ mini.nvim ]]
--
add({ name = 'mini.nvim', checkout = 'HEAD' })
--[[ STEP ONE ]]
----Safely execute immediately
-- Use external plugins with `add()`
now(function()
  local plugin = require('plugins.notify')
  local notify = require(plugin.name)
  notify.setup(plugin.config)
  vim.notify = notify.make_notify()
end)

now(function()
  local plugin = require('plugins.statusline')
  --require('nvim-web-devicons').setup()
  require('mini.statusline').setup(plugin.config)
  -- TODO https://github.com/echasnovski/nvim/blob/master/init.lua
end)


now(function() require('mini.tabline').setup() end)

now(function()
  -- Add to current session (install if absent)
  add({
    source = 'rebelot/kanagawa.nvim',
    checkout = 'master',
  })
  add({
    source = 'nvim-lua/plenary.nvim',
    checkout = 'master',
  })
  add({
    source = 'nvim-tree/nvim-web-devicons',
    checkout = 'master',
  })
  vim.cmd("colorscheme kanagawa")
end)

--[[ STEP TWO ]]
--
-- Safely execute later
later(function()
  -- TODO! https://github.com/echasnovski/nvim/blob/master/init.lua
  local plugin = require('plugins.miniclue')
  require('mini.clue').setup(plugin.config)
end)


later(function()
  add({
    source = 'stevearc/oil.nvim',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    -- monitor = 'main',
    -- Perform action after every checkout
    hooks = {},
  })
  local plugin = require('plugins.oil')
  require('oil').setup(plugin.config)
  plugin.mappings()
end)

--- Commenting
later(function() require('mini.comment').setup() end)

--- Surround
later(function() require("mini.surround").setup() end)

--- Buffer removing (unshow, delete, wipeout), which saves window layout
later(function()
  local plugin = require('plugins.bufremove')
  local bufremove = require(plugin.name)
  bufremove.setup(plugin.config)
  plugin.mappings(bufremove)
end)

--- Visualize and operate on indent scope
later(function() require('mini.indentscope').setup({ symbol = '│', }) end)

--- Trailspace (highlight and remove)
later(function() require("mini.trailspace").setup() end)

--- Automatic highlighting of word under cursor
later(function() require('mini.cursorword').setup() end)

later(function()
  add({
    source = 'akinsho/toggleterm.nvim',
    checkout = 'main',
    hooks = {},
  })
  local plugin = require('plugins.toggleterm')
  require('toggleterm').setup(plugin.config)
  plugin.mappings()
end)

later(function()
  add({
    source = 'lewis6991/gitsigns.nvim',
    checkout = 'main',
  })
  local plugin = require('plugins.gitsigns')
  require('gitsigns').setup(plugin.config)
end)

later(function()
  add({
    source = 'stevearc/resession.nvim',
    checkout = 'master',
  })
  local plugin = require('plugins.resession')
  plugin.setup(plugin.config)
  plugin.mappings()
  plugin.autocommands()
end)

later(function() --Completion and signature help
  -- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-completion.txt
  later(function()
    local plugin = require('plugins.minicompletion')
    plugin.setup(plugin.config)
  end)

  -- add({
  --    source = 'hrsh7th/nvim-cmp',
  --    checkout = 'main',
  --    depends = {
  --      'hrsh7th/cmp-buffer',
  --      'hrsh7th/cmp-path',
  --      'hrsh7th/cmp-nvim-lsp',
  --      'saadparwaiz1/cmp_luasnip',
  --       {
  --       source = 'L3MON4D3/LuaSnip',
  --       depends = {'rafamadriz/friendly-snippets'}
  --       },
  --    }})
end)




-- later(function()
--   add({
--     source = 'ThePrimeagen/harpoon',
--     checkout = 'harpoon2',
--     hooks = { },
--   })
--   local plugin = require('plugins.harpoon')
--   require('harpoon').setup(plugin.config)
--   plugin.mappings()
-- end)
