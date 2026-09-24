local M = {}
M.version = "0.1.0"
M.description = [[
utilities for the show module.  This module is not intended to be used directly by the user, but is used by the other show modules.
 ]]

--[[ coding conventions:
  utility function names:  should be in readable snake_case

function returns:
   prefix is_{this} _has_{that}  etc.  are boolean returns
   example: `get_bufid(bufname)` returns a numeric buffer id handle for the named buffer, or zero on failure
   prefix set_{this} are string returns with an empty string failure to set the value
   example: `set_buf_type` returns a bufType string or empty string on failure

 scope identifiers: scopeIdentifier are readable camelCase strings
   a scopeIdentifier is a string that identifies the scope of a variable.  e.g
   bufType is a variable and reads as this buffer is of a certain type.
   winID A window variable and reads as ithe is a window identifier. ,
   and a tabpage variable would have a scopeIdentifier of "tab".

--]]
--
--- @param bufID integer buffer number
--- @return nil
M.clear_buffer = function(bufID)
  local ok, err, line_count
  ok, line_count = pcall(vim.api.nvim_buf_line_count, bufID)
  if not ok then
    vim.notify('Failed to get line count: ' .. tostring(line_count), vim.log.levels.ERROR)
    return
  end
  vim.bo[bufID].modifiable = true
  -- vim.notify('Buffer is modified, clearing ' .. tostring(line_count) .. ' lines from buffer: ' .. tostring(bufnr), vim.log.levels.INFO)
  if line_count > 1 then
    local strict = false
    local start_line = 0
    local end_line = -1 -- -1 means end of buffer
    ok, err = pcall(vim.api.nvim_buf_set_lines, bufID, start_line, end_line, strict, {})
    if not ok then
      vim.notify('Failed to clear buffer: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end
end

M.data_to_lines = function(data)
  if type(data) == 'string' then
    data = vim.split(data, '\n', { trimempty = false })
  end
  if type(data) ~= 'table' or not vim.islist(data) then
    vim.notify(string.format("Invalid data type. Must be a string or a list of strings."), vim.log.levels.ERROR)
    return {}
  end
  return data
end

-- append new lines to the buffer
--- @param bufID integer buffer number
--- @param data table data to append to the buffer
--- @return nil
M.append_lines = function(bufID, data)
  vim.schedule(function()
    local count_ok, start_line = pcall(vim.api.nvim_buf_line_count, bufID)
    if not count_ok then
      vim.notify('Failed to get line count: ' .. tostring(start_line), vim.log.levels.ERROR)
      return
    end
    local strict = false
    local end_line = start_line + #data - 1 -- -1 because end_line is exclusive
    local ok, err = pcall(vim.api.nvim_buf_set_lines, bufID, start_line, end_line, strict, data)
    if not ok then
      vim.notify('Failed to append lines: ' .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end




--- @param val any
--- @return boolean
M.is_string = function(val)
  return type(val) == 'string' and val ~= ''
end

--- convert string command to table
--- @param str string
--- @return table
M.string_to_table = function(str)
  return vim.split(str, '%s+', { trimempty = true })
end

--- convert table to string command
--- @param tbl table
--- @return string
M.table_to_string = function(tbl)
  if type(tbl) ~= 'table' then
    return ''
  end
  return table.concat(tbl, ' ')
end

--- check if command is executable
--- @param tbl table
--- @return boolean
M.is_executable = function(tbl)
  if type(tbl) ~= 'table' or #tbl == 0 then
    return false
  end
  local cmd_name = tbl[1]
  if not cmd_name or not vim.fn.executable(cmd_name) then
    return false
  end
  return true
end


--- Get ANSI codes for bold and normal text
--- @param tput_name string 'warn' | 'good' | 'caution' | 'reset' | other tput names
--- @return string bold ANSI code for bold text
M.tput_set = function(tput_name)
  if not M.is_string(tput_name) then
    return ''
  end
  if tput_name == 'warn' then
    return vim.system({ 'tput', 'setaf', '1' }, { text = true }):wait().stdout
  end
  if tput_name == 'good' then
    return vim.system({ 'tput', 'setaf', '2' }, { text = true }):wait().stdout
  end
  if tput_name == 'caution' then
    return vim.system({ 'tput', 'setaf', '3' }, { text = true }):wait().stdout
  end
  if tput_name == 'reset' then
    return vim.system({ 'tput', 'sgr0' }, { text = true }):wait().stdout
  end
  -- Text Styling
  local tput_names = {
    'bold',  -- bold
    'dim',   -- dim
    'clear', -- clear screen
    'rev',   --reverse
    'rmul',  -- remove underline
    'sgr0',  -- reset all attributes
    'smul',  -- set underline
  }
  if vim.list_contains(tput_names, tput_name) then
    return vim.system({ 'tput', tput_name }, { text = true }):wait().stdout
  end
  return ''
end



return M
