vim.wo.nu = true
vim.wo.rnu = true
vim.opt_local.list = false
vim.o.buflisted = false

-- Add the cfilter plugin.
vim.cmd.packadd('cfilter')
vim.notify('Quickfix window settings applied', vim.log.levels.INFO)
