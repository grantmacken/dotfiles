vim.opt.showmode = false

---ICONS-
local ok_icons, icons = pcall(require, 'mini.icons')
if ok_icons then
  icons.setup()
end

-----@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  strategy = {
    [''] = 'rainbow-delimiters.strategy.global',
    vim = 'rainbow-delimiters.strategy.local',
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  priority = {
    [''] = 110,
    lua = 210,
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}
--
--
--[[
local ok_tabby, tabby = pcall(require, 'tabby')
if ok_tabby then
  local tabName = function(tabid)
  end
  tabby.setup({
    preset = 'active_wins_at_tail',
    option = {
      theme = {
        fill = 'TabLineFill',       -- tabline background
        head = 'TabLine',           -- head element highlight
        current_tab = 'TabLineSel', -- current tab label highlight
        tab = 'TabLine',            -- other tab label highlight
        win = 'TabLine',            -- window highlight
        tail = 'TabLine',           -- tail element highlight
      },
      nerdfont = true,              -- whether use nerdfont
      lualine_theme = nil,          -- lualine theme name
      tab_name = {
        name_fallback = function(tabid)
          return tabid
        end,
      },
      buf_name = {
        mode = 'unique', -- or 'relative', 'tail', 'shorten'
      },
    },
  })
end
]] --

local mini_plugs = {
  'statusline',
  'git',
  'cursorword',
  'trailspace',
  'hipatterns',
}

for _, plugin in ipairs(mini_plugs) do
  require('mini.' .. plugin).setup()
end


local ok_misc, miniMisc = pcall(require, 'mini.misc')
if ok_misc then
  miniMisc.setup_restore_cursor()
  miniMisc.setup_auto_root({ '.git', 'Makefile' })
  miniMisc.setup_termbg_sync()
end

-- NOTIFY
local ok_notify, miniNotify = pcall(require, 'mini.notify')
if ok_notify then
  local win_config = function()
    local has_statusline = vim.o.laststatus > 0
    local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
    return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
  end
  miniNotify.setup({ window = { config = win_config } })
  vim.notify = miniNotify.make_notify()
else
  vim.notify( 'mini notify not available' )
end

vim.notify( 'OK' )

-- indentscope
local ok_indentscope, indentscope = pcall(require, 'mini.indentscope')
if ok_indentscope then
  indentscope.setup({
    symbol = '│', -- Character to use for indentation lines
    options = {
      try_as_border = true, -- Try to use the symbol as a border
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      'oil',
      "help",
      "notify",
      "toggleterm",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end
  })
end
