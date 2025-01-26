if vim.fn.executable('gleam') ~= 1 then return end
vim.lsp.enable('gleam_ls')

vim.treesitter.start()







