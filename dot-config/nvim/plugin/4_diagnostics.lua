-- NOTE
--[[
NORMAL MODE
]d       : next diag also accepts a count e.g. [d2
]d       : prev diag also accepts a count e.g. [d2
[D       : jump to the first diag
]D       : jump to last last diag
Ctrl+w+d : display error in diagnostic float
K        : :displays hover error from lsp server


opts table key values
 `false`: Disable this feature
 `true`: Enable this feature, use default settings.
 `table`: Enable this feature with overrides. Use an empty table to use default values.
 `function`: Function with signature (namespace, bufnr) that returns any of the above.

]] --


--[[
: h diagnostic signs
: h vim.diagnostic.GetOpts
]] --



local optsSigns = {
  text = {
    [vim.diagnostic.severity.ERROR] = '✘',
    [vim.diagnostic.severity.WARN] = '▲',
    [vim.diagnostic.severity.HINT] = '⚑',
    [vim.diagnostic.severity.INFO] = '»',
  },
  linehl = {
    [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
  },
  numhl = {
    [vim.diagnostic.severity.WARN] = 'WarningMsg',
  },
}

local optsFloat = {
  severity_sort = true,
  focusable = false,
  style = 'minimal',
  border = 'rounded',
  source = 'always',
}

local opts = {
  virtual_text = false,
  signs = optsSigns,
  underline = true,
  update_on_insert = false,
  float = optsFloat,
}

-- global diagnostic config
vim.diagnostic.config(opts)


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group = augroup('diagnostics_cmds', { clear = true })

autocmd('DiagnosticChanged', {
  desc = ' - set quickfix list on diagnostic change',
  group = group,
  callback = function(_)
    -- local diagnostics = args.data.diagnostics
    -- Add all diagnostics to the quickfix list
    vim.diagnostic.setqflist({ open = false }
    )
  end,
})

-- autocmd('CursorHold', {
--   desc = ' - display diagnostic on hover',
--   group = group,
--   callback = function(_)
--     vim.diagnostic.open_float(nil, {focus=false,scope='cursor' })
--   end,
-- })


--[[ AUTO COMMAND ]]
-- autocmd('ModeChanged', {
--   group = group,
--   pattern = { 'n:i', 'v:s' },
--   desc = 'Disable diagnostics while typing',
--   callback = function() vim.diagnostic.disable(0) end
-- })
--
-- autocmd('ModeChanged', {
--   group = group,
--   pattern = 'i:n',
--   desc = 'Enable diagnostics when leaving insert mode',
--   callback = function() vim.diagnostic.enable(0) end
-- })
--


-- TODO
-- use fromqflist
-- see match
