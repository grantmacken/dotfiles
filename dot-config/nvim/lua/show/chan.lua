local M = {}
M.version = "0.1.0"
M.description = [[ terminal channel management for bufShell and bufTask buffers
 - Get OR create a terminal channel running for buffer types bufShell or bufTask
 - If channel already exists, return existing channel ID
 - bufShell{Name): If channel does not exist, create new terminal channel and return channel ID
 - bufTask{Name}  If channel does not exist, use open create new terminal channel and return channel ID
 - bufScratch: scratch buffer does not have a channel
    However, prior to sending data calling show.channel('bufScratch') will clear buffer before writing new data.
    Use send function to write data to the scratch buffer one or many lines at a time.
    Each send `appends` new data to the scratch buffer.
    With a new data set the scratch buffer can be cleared first by calling show.channel('bufScratch')

]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] todo task 1
 - [ ] todo task 3
]]

M.references = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

--- @param bufID integer buffer number
--- @return boolean
local has_chan = function(bufID)
  local ok, chanID
  ok, chanID = pcall(vim.api.nvim_buf_get_var, bufID, 'channel')
  if not ok or chanID == nil or chanID <= 0 then
    return false
  end
  return true
end

--- @param bufID integer buffer number
--- @return integer channel ID or zero on failure
local get_chan_id = function(bufID)
  local ok, res = pcall(vim.api.nvim_buf_get_var, bufID, 'channel')
  if not ok then
    vim.notify(string.format("Failed to get channel for buffer '%s': %s", bufID, res),
      vim.log.levels.ERROR)
    return 0
  end
  if res == nil or res <= 0 then
    return 0
  end
  return res
end

--[[ create_job_id
use jobstart to create a new terminal job which opens a new bash channel.
the channel ID is stored in the buffer variable 'channel' for later use.
  jobstart() return values
  - |channel-id| on success
  - 0 on invalid arguments
  - -1 if {cmd}[0] is not executable
--]]

local shell = vim.o.shell
local job_opts = {
  cwd = vim.uv.cwd(),
  term = true,      -- Spawns {cmd} in a new pseudo-terminal session
  clear_env = true, -- start with a clean environment
  --env = env,        -- set up environment variables
  --stdout_buffered = true, -- buffer stdout until job exits
  -- stderr_buffered = true, -- buffer stderr until job exits
  -- pty = false,            -- use a pseudo-terminal
}
---@param bufID integer buffer number
---@return integer channel ID or zero on failure
local create_job_id = function(bufID)
  return vim.api.nvim_buf_call(bufID, function()
    local ok, jobID = pcall(vim.fn.jobstart, shell, job_opts)
    if not ok or jobID == nil or jobID <= 0 then
      vim.notify(string.format("Failed to create shell channel for buffer '%s': %s", bufID, tostring(jobID)),
        vim.log.levels.ERROR)
      return 0
    end
    vim.api.nvim_buf_set_var(bufID, 'channel', jobID)
    return jobID
  end)
end

-- --- @param bufID integer buffer number
-- --- @return integer channel ID or zero on failure
-- local get_channel_id = function(bufID)
--   local ok, chanID
--   ok, chanID = pcall(vim.api.nvim_buf_get_var, bufID, 'channel')
--   if not ok or chanID == nil or chanID <= 0 then
--     ok, chanID = pcall(vim.api.nvim_open_term, bufID, { force_crlf = true })
--     if not ok then return 0 end
--     vim.api.nvim_buf_set_var(bufID, 'channel', chanID)
--   end
--   return chanID
-- end
--
--
-- -- local ok, err = pcall(vim.api.nvim_buf_call, bufID, function()
-- --     -- set up environment variables for the shell job
-- --     local env = vim.tbl_extend("force", {}, vim.uv.os_environ(), {
-- --       NVIM = vim.v.servername,
-- --       NVIM_LOG_FILE = false,
-- --       VIM = false,
-- --       VIMRUNTIME = false,
-- --       COPILOT_DISABLE = '1',
-- --       -- TERM = "xterm-256color", -- set by default when term=true
-- --     })
-- --     local shell = vim.o.shell
-- --     local opts = {
-- --       cwd = vim.uv.cwd(),
-- --       term = true,      -- Spawns {cmd} in a new pseudo-terminal session
-- --       clear_env = true, -- start with a clean environment
-- --       env = env,        -- set up environment variables
-- --       --stdout_buffered = true, -- buffer stdout until job exits
-- --       -- stderr_buffered = true, -- buffer stderr until job exits
-- --       -- pty = false,            -- use a pseudo-terminal
-- --     }
-- --     --[[
-- --     use jobstart to create a new terminal job which opens a new bash channel.
-- --     the channel ID is stored in the buffer variable 'channel' for later use.
-- --      jobstart() return values
-- --       - |channel-id| on success
-- --       - 0 on invalid arguments
-- --       - -1 if {cmd}[0] is not executable
-- --     --]]
-- --     local jobID = vim.fn.jobstart(shell, opts)
-- --     if jobID <= 0 then
-- --       local err_msg = jobID == 0 and 'invalid arguments' or 'shell not executable'
-- --       vim.notify('Failed to start shell: ' .. err_msg, vim.log.levels.ERROR)
-- --       return
-- --     end
-- --     local set_ok, set_err = pcall(vim.api.nvim_buf_set_var, bufID, 'channel', jobID)
-- --     if not set_ok then
-- --       vim.notify('Failed to set channel var: ' .. tostring(set_err), vim.log.levels.ERROR)
-- --     end
-- --   end)
-- --   if not ok then
-- --     vim.notify('Failed to call buffer: ' .. tostring(err), vim.log.levels.ERROR)
-- --   end
--
--
--
--
--
-- local create_channel = function(bufID)
--   local chanID = 0
--   local ok, err
--   local bufName = vim.api.nvim_buf_get_name(bufID)
--   local bufType = set_buf_type(bufName)
--   if bufType == 'bufShell' then

--     -- local shell_env = vim.tbl_extend("force", {}, vim.uv.os_environ(), {
--     --   NVIM = vim.v.servername,
--     --   NVIM_LOG_FILE = false,
--     --   VIM = false,
--     --   VIMRUNTIME = false,
--     --   COPILOT_DISABLE = '1',
--     --   -- TERM = "xterm-256color", -- set by default when term=true
--     -- })
--
--     local opts = {
--       cwd = vim.uv.cwd(),
--       term = true,      -- Spawns {cmd} in a new pseudo-terminal session
--       clear_env = true, -- start with a clean environment
--       -- env = shell_env, -- set up environment variables
--       --stdout_buffered = true, -- buffer stdout until job exits
--       -- stderr_buffered = true, -- buffer stderr until job exits
--       -- pty = false,            -- use a pseudo-terminal
--     }
--
--     ok, chanID = pcall(vim.fn.jobstart, vim.o.shell, opts)
--     if not ok or type(chanID) == 'number' then
--       vim.notify(string.format("Failed to create shell channel for buffer '%s': %s", bufName, tostring(chanID)),
--         vim.log.levels.ERROR)
--       return 0
--     end
--     if chanID <= 0 then
--       return 0
--     end
--     vim.notify(string.format("Created shell channel %d for buffer '%s'", chanID, bufName), vim.log.levels.DEBUG)
--     ok, err = pcall(vim.api.nvim_buf_set_var, bufID, 'channel', chanID)
--     if not ok then
--       vim.notify('Failed to set channel var: ' .. tostring(err), vim.log.levels.ERROR)
--       return 0
--     end
--     return chanID
--   elseif bufType == 'bufTask' then
--     -- create a new task channel for the buffer
--     vim.notify(string.format("Creating new task channel for buffer '%s'", bufName), vim.log.levels.DEBUG)
--     local opts = { force_crlf = true, }
--     ok, chanID = pcall(vim.api.nvim_open_term, bufID, opts)
--     if not ok or chanID == nil or chanID <= 0 then
--       vim.notify(string.format("Failed to create task channel for buffer '%s': %s", bufName, tostring(chanID)),
--         vim.log.levels.ERROR)
--       return 0
--     end
--     ok, err = pcall(vim.api.nvim_buf_set_var, bufID, 'channel', chanID)
--     if not ok then
--       vim.notify('Failed to set channel var: ' .. tostring(err), vim.log.levels.ERROR)
--     end
--     return chanID
--   else
--     return 0
--   end
-- end
--
M.has_chan = has_chan
M.get_chan_id = get_chan_id
M.create_job_id = create_job_id
return M
--
