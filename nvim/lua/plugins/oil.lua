-- plugin setup config options
local config = {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,}
  }

-- plugin leader mappings
local mappings = function()
-- local  map_leader = util.nmap_leader	
  vim.keymap.set('n', '-', function() vim.cmd.Oil() end, { desc = '[oil] open parent directory' })
end

  require('oil').setup(config)
  mappings()

