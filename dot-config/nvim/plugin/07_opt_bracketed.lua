--[=[
Neovim 0.13 built-in bracket mappings
=======================================

Use `:help lsp-defaults`, `:help default-mappings`, and `:help 2.3` for
the authoritative documentation. `[x` generally moves backward and `]x`
generally moves forward.

Diagnostics
-----------
| Key | Action |
| --- | --- |
| `[d` | Previous diagnostic in the current buffer |
| `]d` | Next diagnostic in the current buffer |
| `[D` | First diagnostic in the current buffer |
| `]D` | Last diagnostic in the current buffer |

Quickfix and location lists
---------------------------
| Key | Action |
| --- | --- |
| `[q` / `]q` | Previous / next quickfix entry |
| `[Q` / `]Q` | First / last quickfix entry |
| `[l` / `]l` | Previous / next location-list entry |
| `[L` / `]L` | First / last location-list entry |
| `[<C-Q>` | Previous quickfix entry in the previous file |
| `[<C-L>` | Previous location-list entry in the previous file |

Buffers and argument lists
--------------------------
| Key | Action |
| --- | --- |
| `[b` / `]b` | Previous / next buffer |
| `[B` / `]B` | First / last buffer |
| `[a` / `]a` | Previous / next argument-list file |
| `[A` / `]A` | First / last argument-list file |

Tags and preview windows
------------------------
| Key | Action |
| --- | --- |
| `[t` / `]t` | Previous / next tag |
| `[T` / `]T` | First / last tag |
| `[<C-T>` | Previous tag in the preview window |

Classic navigation and structure
--------------------------------
| Key | Action |
| --- | --- |
| `[#` / `]#` | Previous / next unmatched preprocessor condition |
| `['` / `]'` | Previous / next lowercase mark, first nonblank |
| ``[` `` / ``]` `` | Previous / next lowercase mark |
| `[(` / `])` | Previous / next unmatched parenthesis |
| `[{` / `]}` | Previous / next unmatched brace |
| `[/` / `]/` | Previous C-comment start / end |
| `[*` / `]*` | Same as `[/` and `]/` |
| `[c` / `]c` | Previous / next change |
| `[[` / `]]` | Previous / next section |
| `[]` / `][` | Previous / next section boundary |
| `[m` / `]m` | Previous method start / next method end |
| `[M` / `]M` | Previous method end / next method start |
| `[<Space>` | Add an empty line above the cursor |
| `]<Space>` | Add an empty line below the cursor |

Paste commands
--------------
| Key | Action |
| --- | --- |
| `[p` / `[P` | Paste with indentation adjusted to the current line |
| `[<MiddleMouse>` | Paste with indentation adjusted to the current line |

Spelling and include search
---------------------------
| Key | Action |
| --- | --- |
| `[s` / `]s` | Previous / next misspelled word |
| `[S` / `]S` | Previous / next bad word only |
| `[r` / `]r` | Previous / next rare word |
| `[i` / `]i` | Include-search line lookup |
| `[I` / `]I` | List include-search lines |
| `[f` / `]f` | Same as `gf` |
| `[<C-D>` | Jump to a previous matching `#define` |
| `[<C-I>` | Jump to a previous matching line |

Treesitter selection and multicursor
------------------------------------
| Key | Mode | Action |
| --- | --- | --- |
| `[n` / `]n` | Visual | Select previous / next Treesitter node |
| `[N` / `]N` | Visual | Extend selection to previous / next sibling node |
| `[C` / `]C` | Normal | Jump to previous / next multicursor |
| `an` | Visual/operator-pending | Select the outer/parent syntax node |
| `in` | Visual/operator-pending | Select the inner/child syntax node |

`an` and `in` are syntax-node text objects, not specifically inner/outer line
]=]

--- custom bracketed mappings
-- TODO: use function to cycle through tabs instead of just going to the next/previous tab
vim.keymap.set("n", "[<PageUp>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "]<PageDown>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

-- override default mappings for arglist navigation to use custom arglist module
--- custom bracketed mappings for arglist navigation

vim.keymap.set("n", "[a", function()
  local nav = require("arglist").nav
  nav(-vim.v.count1)
  -- vim.cmd("args")
end)

vim.keymap.set("n", "]a", function()
  local nav = require("arglist").nav
  nav(vim.v.count1)
  -- vim.cmd("args")
end)
