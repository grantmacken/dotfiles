local ok, copilot = pcall(require,'copilot')
if not ok then return end
-- @see hittps://www.lazyvim.org/extras/ai/copilot
copilot.setup({
  panel = { enabled = false },
  suggestion = {
  enabled = true,
  auto_trigger = true,
  }
})
-- Keymaps

local k = require('keymaps')
local suggestion = require('copilot.suggestion')
--[[
When auto_trigger is false, use the next or prev keymap to trigger copilot suggestion
M-l     : accept
M-]     : next suggestion
M-[     : previous suggestion
C-]>    : dismiss suggestion
--]]
 k.iMap('<M-w>',suggestion.accept_word,' suggestion accept [w]ord' )
 k.iMap('<M-e>',suggestion.accept_line,' suggestion accept to line [e]nd' )

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
