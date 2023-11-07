local M = {}
local log  = require('my.util').log
local cmd  = vim.api.nvim_create_user_command

local Dune = function()
  cmd("DuneUtop", [[:botright split | term utop]], {})
  cmd("DuneBuildWatch", [[:rightbelow :5split +set\ nonu term://dune build @install --watch]], {})
end

cmd("SessionSave",
  function(_)
    require('resession').save(require('my.util').get_session_name())
  end, {}
)

cmd("SessionLoad",
  function(_)
    require('resession').load(require('my.util').get_session_name())
  end, {})

M.setup = function()
  Dune()
  log( 'vim commands setup completed' )
end

return M
