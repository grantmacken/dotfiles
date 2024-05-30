local name = 'toggleterm'
local config = {
  size = function(term)
    if term.direction == 'horizontal' then
     return vim.o.lines * 0.6
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.5
    end
  end,
  open_mapping =  [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = false,
  auto_scroll = false,
  -- This field is only relevant if direction is set to 'float'
  autochdir = false,
  persist_mode = true,
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}

require(name).setup(config)


