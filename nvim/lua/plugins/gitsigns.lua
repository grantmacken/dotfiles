local M = {}
M.name = ''
local util = require('my.util')
local nmap_leader = util.nmap_leader
local nmap = util.nmap
local untracked = false -- used to be true by default

local signs = {
  add = { text = "▎" },
  change = { text = "▎" },
  delete = { text = "" },
  topdelete = { text = "" },
  changedelete = { text = "▎" },
  untracked = { text = "▎" },
}

local on_attach = function(buffer)
    local gs = package.loaded.gitsigns
    nmap("]h", gs.next_hunk, "Next hunk",{ buffer = buffer})
    nmap("[h", gs.prev_hunk, "Prev hunk", { buffer = buffer})
    --map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
    --map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
    nmap_leader("ghS", gs.stage_buffer, "Stage buffer",{ buffer = buffer})
    -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
    -- map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
    -- map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk")
    -- map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
    -- map("n", "<leader>ghd", gs.diffthis, "Diff this")
    -- map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff this ~")
    -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns select hunk")
  end


-- plugin setup config options
M.config = {
  attach_to_untracked = false,
  signs = signs,
  on_attach = on_attach
}

-- plugin leader mappings
M.mappings = function()
-- g is for 'git
end

return M
