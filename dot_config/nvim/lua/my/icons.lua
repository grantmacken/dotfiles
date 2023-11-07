local M = {}

M.ui = {
  search = '',
  select = '❯',
  LSPLoaded = '',
  LSPLoading1 = '',
  LSPLoading2 = '',
}

M.diagnostics = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}
M.git = {
  added = ' ',
  modified = ' ',
  removed = ' ',
  untracked = '★',
}
M.kinds = {
  Array = ' ',
  Boolean = ' ',
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Copilot = ' ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = ' ',
  Interface = ' ',
  Key = ' ',
  Keyword = ' ',
  Method = ' ',
  Module = ' ',
  Namespace = ' ',
  Null = 'ﳠ ',
  Number = ' ',
  Object = ' ',
  Operator = ' ',
  Package = ' ',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  String = ' ',
  Struct = ' ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = ' ',
}
return M
