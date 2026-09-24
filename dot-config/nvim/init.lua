-- Initialization =============================================================
-- Enable Lua module loader for faster startup
vim.loader.enable()
-- ui2: native Neovim 0.12+ message/cmdline redesign
-- provides pager as a buffer+window.
-- default options
require("vim._core.ui2").enable({
  enable = true,               -- Whether to enable or disable the UI.
  targets = {
    default       = 'cmd',     -- Standard fallback
    echo          = 'msg',     -- Brief :echo output goes to a popup
    wmsg          = 'msg',     -- Warnings float briefly without halting workflow
    echoerr       = 'pager',   -- Aggressive errors go straight to the pager
    lua_error     = 'pager',   -- Syntax/runtime crashes go to the pager
    search_count  = 'cmd',     -- [1/20] matches stay on the command line
    return_prompt = 'discard', -- Return prompt is not useful to see
  },
  cmd = {                      -- Options related to messages in the cmdline window.
    height = 0.3,              -- Maximum height while expanded for messages beyond 'cmdheight'.
  },
  dialog = {                   -- Options related to dialog window.
    height = 0.3,              -- Maximum height.
  },
  msg = {                      -- Options related to msg window.
    height = 0.3,              -- Maximum height.
    timeout = 8000,            -- Time a message is visible in the message window.
  },
  pager = {                    -- Options related to message window.
    height = 0.4,              -- Maximum height.
  },
})

-- disable built-in plugins
local plugins = {
  'gzip',
  'netrwPlugin',
  'rplugin',
  'tarPlugin',
  'tohtml',
  'tutor',
  'zipPlugin',
}
for _, plugin in ipairs(plugins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.pack.add({
  'gh:rebelot/kanagawa.nvim', -- colorscheme
  'gh:webhooked/kanso.nvim',  -- colorscheme
  'gh:nvim-mini/mini.test',   -- testing framework
  'gh:nvim-mini/mini.icons',
  'gh:nvim-mini/mini.clue',
  'gh:lewis6991/gitsigns.nvim',
  'gh:nvim-mini/mini.completion',
  'gh:nvim-mini/mini.snippets',
  'gh:nvim-mini/mini.keymap',
  'gh:rachartier/tiny-inline-diagnostic.nvim',

}, { confirm = false })
