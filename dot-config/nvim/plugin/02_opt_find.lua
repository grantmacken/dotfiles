--[[ FILE SEARCHING
## Docs
  - https://neovim.io/doc/user/options.html#'path'
  - https://neovim.io/doc/user/options.html#'suffixesadd'
  - https://neovim.io/doc/user/options.html#'include'
  - https://neovim.io/doc/user/options.html#'includeexpr'
## Built-in keybindings
  - gf: go to file under cursor
  - :find: find file in path
  - :sfind: find file in path and open in a split window
  - :tabfind: find file in path and open in a new tab
## Notes
  - The 'path' option is a list of directories that are searched when using the gf command or the :find command.
  - The 'suffixesadd' option is a list of suffixes that are added to the file name when searching for a file.
  - The 'include' option is a pattern that is used to find files that are included in the current file.
  - The 'includeexpr' option is an expression that is used to transform the file name before searching for it.
The built in findprg
]]

vim.o.path = vim.o.path .. ",**" -- Search in subdirectories
-- path is the list of directories searched by gf (and :find).
local ignore_patterns = {
  "node_modules",
  "%.git",
  "%.cache",
  "dist",
  "build",
  "tmp",
  "%.tmp",
  "%.log",
}

function _G.fuzzy_find(text, _)
  local files = vim.fn.glob("**/*", true, true)
  local result = {}
  for _, f in ipairs(files) do
    if vim.fn.isdirectory(f) == 0 then
      local skip = false
      for _, pat in ipairs(ignore_patterns) do
        if f:match(pat) then
          skip = true
          break
        end
      end
      if not skip then
        result[#result + 1] = f
      end
    end
  end
  return vim.fn.matchfuzzy(result, text)
end

vim.opt.findfunc = "v:lua.fuzzy_find"

