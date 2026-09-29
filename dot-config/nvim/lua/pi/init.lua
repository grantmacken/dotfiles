local M = {}
M.version = "0.1.0"
M.description = [[
 Provide Neovim-callable functaions for distinct pi-agent operational modes.
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

local async = vim.async
local run = async.run
local wrap = async.wrap
---@type async fun(cmd: string[], opts: vim.SystemOpts): vim.SystemCompleted
local system = wrap(3, vim.system)
local show = require('show')
local show_win = require('show.win')

local function get_ptyxis_profile()
  local obj = vim.system({
        "host-spawn",
        "dconf", "read", "/org/gnome/Ptyxis/default-profile-uuid"
      }, { text = true })
      :wait()
  return obj.stdout:gsub("\n", ""):gsub("'", "") or nil -- Remove newline and quotes
end

local get_ptyxis_cmd = function()
  local cmd = {
    "host-spawn",
    "ptyxis",
    "--standalone",
    "--new-window",
    "--maximize"
  }
  vim.list_extend(cmd, {
    "--tab-with-profile=" .. get_ptyxis_profile(),
    "--title=pi-agent-" .. vim.fs.basename(vim.uv.cwd()),
  })
  return cmd
end

--- open the latest session in the current directory
M.agentContinue = function()
  local working_dir = vim.uv.cwd()
  run(function()
    local cmd = get_ptyxis_cmd()
    vim.list_extend(cmd, {
      "--",
      "pi",
    })
    local obj = system(cmd, {
      cwd = working_dir,
      detach = true,
    })
    return
  end)
  -- local job = task:wait()
  -- vim.print(job)
  -- if job.code == 0 then
  --   vim.notify(string.format("Successfully launched pi-agent for %s", basename), vim.log.levels.INFO)
  -- else
  --   vim.notify(string.format("Error running pi-agent list: %s", job.stderr), vim.log.levels.ERROR)
  -- end
end

--- opens a new pi-agent session in a standalone Ptyxis window for the current working directory
M.agentNew = function()
  local working_dir = vim.uv.cwd()
  local basename = vim.fs.basename(working_dir)
  local cmd = get_ptyxis_cmd()
  vim.list_extend(cmd, {
    "--",
    "pi",
  })
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

--- Ask Pi to commit changes scoped to the saved file in the current buffer.
--- @return vim.async.Task<integer>|nil task running the Pi command, or nil if validation fails
M.agentScopedCommit = function()
  local bufID = vim.api.nvim_get_current_buf()
  local bufName = vim.api.nvim_buf_get_name(bufID)
  if bufName == '' then
    vim.notify('Cannot run a scoped commit for an unnamed buffer', vim.log.levels.ERROR)
    return
  end
  if vim.bo[bufID].modified then
    vim.notify('Save the current buffer before running a scoped commit', vim.log.levels.ERROR)
    return
  end

  local working_dir = vim.uv.cwd()
  local filePath = vim.fn.fnamemodify(bufName, ':p')
  local relPath = vim.fs.relpath(working_dir, filePath)
  if not relPath or relPath == '..' or relPath:match('^%.%./') then
    vim.notify('The current buffer file must be inside the working directory', vim.log.levels.ERROR)
    return
  end
  if vim.fn.filereadable(filePath) ~= 1 then
    vim.notify(string.format('Saved file is not readable: %s', filePath), vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable('pi') ~= 1 then
    vim.notify('Cannot run scoped commit: pi is not executable', vim.log.levels.ERROR)
    return
  end

  local prompt = string.format([[
Read the attached saved file `%s` and inspect Git changes scoped only to that file.
Create a single commit containing changes to that file only; do not include or modify other files.
For tracked files, use a path-limited commit such as `git commit --only -- %s`; if untracked, stage only that file.
Follow repository instructions for an imperative, scoped commit subject. If this file has no changes to commit, report that and do not create an empty commit.
]], relPath, relPath)
  local cmd = {
    'pi',
    '--approve',
    '--model', 'github-copilot/gemini-3.5-flash',
    '--thinking', 'minimal',
    '--tools', 'read,bash',
    '-p',
    '@' .. relPath,
    prompt,
  }

  local task = run(function()
    local ok, job = async.pawait(3, vim.system, cmd, { cwd = working_dir, text = true })
    local output
    if ok then
      output = job.stdout or ''
      if job.stderr and job.stderr ~= '' then
        output = output .. (output ~= '' and '\n' or '') .. job.stderr
      end
      if job.code ~= 0 then
        output = string.format('pi exited with code %d\n\n%s', job.code, output)
      end
    else
      output = 'Failed to run pi: ' .. tostring(job)
    end
    if output == '' then
      output = 'pi completed without producing output.'
    end

    -- Resume through vim.async's scheduler before calling Neovim APIs.
    async.sleep(0)
    local outputBufID = show.data('bufScratchPi', output, { filetype = 'text' })
    local winID = show_win.get_win_id()
    if outputBufID == 0 or winID == 0 or not show_win.show_buffer_in_show_window(winID, outputBufID) then
      vim.notify('Failed to display scoped commit output in the show window', vim.log.levels.ERROR)
      return 0
    end
    return outputBufID
  end)
  return task
end



-- set default function for M.PiAgent to be M.agentContinue, so that calling M.PiAgent() will invoke the agentContinue function
M.PiAgent = M.agentContinue

return M
