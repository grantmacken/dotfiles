--[[
User defined commands for neovim, with a consistent naming convention and description generation.
-- NOTE: unlike the lua module pattern: M does not return anything, it is just a container for functions and data.
Command conventions: begin with name: first letter uppercase, then more context:  e.g. "UtilCopyRelativePathToClipboard"
     - the function to call is the substring after first word e.g. "Issue", with the first letter  of the second word lowercased e.g. "CopyRelativePathToClipboard" -> "copyRelativePathToClipboard"
     - the description for the command is the cmd  split into words, e.g. "UtilCopyRelativePathToClipboard" -> "Util Copy Relative Path To Clipboard""
     - the spliting function call is cmd:gsub("%u", " %0"):gsub("^%s+", "")
]]

local git_list = {
  'GitAddFile',
  'GitCommitFile',
  'GitLog',
  'GitStatusList',
  'GitPush',
  --  'GitStatusToQuickfix',
}

require('commands').set(git_list)


local cmd_list = {
  'PiAgent',
  'RepoIssueList',
  'SearchGrepInputIntoQf',
  'TemplatesCreateLuaModule',
  'UtilNvimServerList',
  'UtilSaveAndQuit',
}

require('commands').set(cmd_list)
