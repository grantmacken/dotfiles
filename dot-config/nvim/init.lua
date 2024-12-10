-- Initialization =============================================================
pcall(function()
  vim.loader.enable()
  vim.deprecate = function() end
end)

require('conf')
