local M = {}
M.version = "0.1.0"
M.description = [[
 - Create a buffer by name if it does not exist
 - if bufName is invalid, return error notification and exit
 - If buffer already exists, return existing buffer number
 - If buffer does not exist, create new buffer and return buffer number
 - A valid buffer name type is one of [ 'bufShell', 'bufScratch', or 'bufTask', 'bufEdit' ]
 - the type prefix is used to determine how to create and manage the buffer
 - this happens in the channel() function not here
]]

-- A TODO list of tasks to be completed for the module's implementation
-- M.implementation = [[
--  - [ ] todo task 1
--  - [ ] todo task 3
-- ]]
--
-- M.references = [[
--  - reference 1 url to gh issue or discussion
--  - reference 2 file path to local documentation
-- ]]
--

local BufTypes = { 'bufScratch', 'bufTask', 'bufEdit', 'bufShell' }

---@param bufName string buffer name like 'bufScratchDefault'
---@return boolean is_buf_type true if bufName is a valid buffer name type, false otherwise
local is_buf_type = function(bufName)
  for _, bufType in ipairs(BufTypes) do
    if vim.startswith(bufName, bufType) then
      return true
    end
  end
  return false
end

---@param bufName string buffer name like 'bufScratchDefault'
---@return string bufType or empty string on failure
local set_buf_type = function(bufName)
  for _, bufType in ipairs(BufTypes) do
    if vim.startswith(bufName, bufType) then
      return bufType
    end
  end
  return ''
end

---@param bufName string buffer name like 'bufScratchDefault'
---@return integer bufID buffer ID or zero on failure
local get_buf_id = function(bufName)
  for _, bufID in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(bufID):match(bufName) then
      return bufID
    end
  end
  return 0
end



--[[
  - Create a buffer by name if it does not exist
  - if bufName is invalid, return error notification and exit
  - If buffer already exists, return existing buffer number
  - If buffer does not exist, create new buffer and return buffer number
  - A valid buffer name type is one of [ 'bufShell', 'bufScratch', or 'bufTask', 'bufEdit' ]
  - the type prefix is used to determine how to create and manage the buffer
   - this happent in the channel() function not here
 ]]

---@param bufName string buffer name like 'bufScratchDefault'
---@return integer bufID or zero on failure
local create_buffer = function(bufName)
  if not is_buf_type(bufName) then
    vim.notify(string.format("Invalid buffer name '%s'. Must be one of: %s", bufName, table.concat(BufTypes, ", ")),
      vim.log.levels.ERROR)
    return 0
  end
  -- otherwise create new buffer
  local bufType = set_buf_type(bufName)
  -- if buf_type is bufEdit create listed normal buffer
  -- if buf_type is bufScratch or bufTask or bufShell create unlisted scratch buffer
  local oListed = false
  local oScratch = true
  if bufType == 'bufEdit' then
    oListed = true
    oScratch = false
  end
  local bufID = vim.api.nvim_create_buf(oListed, oScratch)
  if bufID == 0 then return 0 end
  vim.api.nvim_buf_set_name(bufID, bufName)
  -- Store in tab variable
  local tabID = vim.api.nvim_get_current_tabpage()
  vim.api.nvim_tabpage_set_var(tabID, bufName, bufID)
  return bufID
end

M.set_buf_type = set_buf_type
M.get_buf_id = get_buf_id
M.create_buffer = create_buffer
return M
