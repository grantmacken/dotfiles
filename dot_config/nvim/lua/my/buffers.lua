local M = {}
M.is_valid = function(bufnr)
  if not bufnr or bufnr < 1 then
    return false
  end
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end
return M
