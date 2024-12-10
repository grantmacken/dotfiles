local au = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

-- Highlight yanked text
au("TextYankPost", {
  pattern = "*",
  desc = 'Highlight when yanking text',
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})

-- Autosave
au({ "InsertLeave", "FocusLost" }, {
  pattern = "<buffer>",
  command = "silent! write",
})

-- Update file on external changes
au({ "FocusGained", "TermClose", "TermLeave" }, {
  pattern = "<buffer>",
  command = "checktime",
})

-- Quickly exit help pages
au("FileType", {
  pattern = { "help", "notify", "checkhealth", "oil", "copilot-chat"},
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      silent = true,
      buffer = true,
    })
  end,
})

  vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-chat",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})



-- au("TermClose", {


-- Disable numbering, folding and signcolumn in Man pages and terminal buffers
-- local function disable_ui_settings()
--   local opts = {
--     number = false,
--     relativenumber = false,
--     signcolumn = "no",
--     foldcolumn = "0",
--     foldlevel = 999,
--   }
--   for opt, val in pairs(opts) do
--     vim.opt_local[opt] = val
--   end
-- end
--
-- local function start_term_mode()
--   disable_ui_settings()
--   vim.cmd("startinsert!")
-- end
--
-- au({ "BufEnter", "BufWinEnter" }, {
--   pattern = "man://*",
--   callback = disable_ui_settings,
-- })
--
-- au("TermOpen", {
--   pattern = "term://*",
--   callback = start_term_mode,
-- })
