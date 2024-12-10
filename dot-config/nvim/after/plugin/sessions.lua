local ok, sessions = pcall(require,'mini.sessions')
if not ok then return end
sessions.setup({
  autoread = true,
  autowrite = true,
  directory = vim.fn.stdpath('state') .. '/session',
  file = 'session.vim',
})
