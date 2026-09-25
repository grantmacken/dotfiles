local M = {}
M.version = "0.1.0"
M.description = [[
 Provide Neovim-callable functions for distinct pi-agent operational modes.
 - overview: launches pi in standalone Ptyxis sessions or runs flagged prompts for display in the show window
 - scope: owns pi process launching, argument construction, and mode-specific flags; plugin files own commands and keymaps
 - usage: require('pi') from plugin files and call public functions for standalone sessions or show-window prompts
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [x] Launch pi in a standalone Ptyxis session for the current working directory.
 - [ ] Add pi-agent modes for launching pi with different models and thinking modes.
 - [ ] Add pi-agent operational modes for flagged prompts and show-window output.
]]

M.references = [[
 - ../util/init.lua
 - ../../plugin/10_user_commands.lua
 - ../show/init.lua
]]




M.agent = function()
  local working_dir = vim.uv.cwd()
  local basename = vim.fs.basename(working_dir)
  local obj = vim.system({
        "host-spawn",
        "dconf", "read", "/org/gnome/Ptyxis/default-profile-uuid"
      }, { text = true })
      :wait()
  if obj.code ~= 0 then
    vim.notify(string.format("Error reading dconf: %s", obj.stderr), vim.log.levels.ERROR)
    return
  end
  local ptyxis_profile = obj.stdout:gsub("\n", ""):gsub("'", "") -- Remove newline and quotes
  if ptyxis_profile == nil then
    vim.notify("PTYXIS_PROFILE_UUID is not set. Please set it in your environment.", vim.log.levels.ERROR)
    return
  end
  local cmd = {
    'host-spawn',
    'ptyxis',
    '--fullscreen',
    '--maximize',
    '--title="pi-agent: ' .. basename .. '"',
    '--standalone',
    '--tab-with-profile="' .. ptyxis_profile .. '"',
    '--',
    'pi',
  }
  --
  vim.system(cmd, {
    cwd = working_dir,
    detach = true,
  }, function(job)
    if job.code == 0 then
      vim.notify(string.format("Successfully launched pi-agent for %s", basename), vim.log.levels.INFO)
    else
      vim.notify(string.format("Error running pi-agent list: %s", job.stderr), vim.log.levels.ERROR)
    end
  end)
end

return M
