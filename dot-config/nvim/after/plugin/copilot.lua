local ok, copilot = pcall(require,'copilot')
if not ok then return end
-- @see hittps://www.lazyvim.org/extras/ai/copilot
copilot.setup({
  panel = { enabled = false },
  suggestion = {
    accept = false,
  }
})
--[[ default mappings
--]]
-- copilot.suggestion.accept = function(modifier)
--   copilot.suggestion.accept(modifier)
--   vim.cmd('stopinsert')
-- end


-- vim.print('copilot setup')o
--[[
The copilot.suggestion module exposes the following functions:
require("copilot.suggestion").is_visible()
require("copilot.suggestion").accept(modifier)
require("copilot.suggestion").accept_word()
require("copilot.suggestion").accept_line()
require("copilot.suggestion").next()
require("copilot.suggestion").prev()
require("copilot.suggestion").dismiss()
require("copilot.suggestion").toggle_auto_trigger()
]]--
