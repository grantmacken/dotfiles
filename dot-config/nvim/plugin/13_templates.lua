group = vim.api.nvim_create_augroup("templates", { clear = true })
local templates = {
  {
    event = "BufNewFile",
    pattern = "*/lua/*/*.lua",
    group = group,
    callback = function(args)
      local path = vim.fs.joinpath(
        vim.fn.stdpath("config"),
        "templates",
        'lua_module.' .. vim.fs.ext(args.file)
      )
      if vim.uv.fs_stat(path) then
        vim.cmd("0r " .. path)
      end
    end,
    desc = "Insert template for new lua module files",
  },
}

require('autocmds').set_callbacks(templates)
