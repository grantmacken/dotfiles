vim.wo.nu = false
vim.wo.rnu = false
vim.opt_local.list = false
vim.o.buflisted = false

-- Add the cfilter plugin.
vim.cmd.packadd('cfilter')
vim.notify('Quickfix window settings applied', vim.log.levels.INFO)

-- close with q
vim.keymap.set('n', 'q', '<cmd>close<CR>')
