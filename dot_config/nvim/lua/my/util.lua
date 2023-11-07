local M = {}

local function get_session_name()
  local name = vim.fn.getcwd()
  local branch = vim.trim(vim.fn.system("git branch --show-current"))
  if vim.v.shell_error == 0 then
    return name .. '_' .. branch
  else
    return name
  end
end

local log = function(msg)
  local fp = io.open( 'my.log', "a")
  fp:write(string.format("[%-6s%s] %s\n", 'INFO', os.date(), msg))
  fp:close()
end

local clear_log = function()
  local fp = io.open( 'my.log', "w")
  fp:write('')
  fp:close()
end



M.get_session_name = get_session_name
M.log = log
M.clear_log = clear_log


return M
