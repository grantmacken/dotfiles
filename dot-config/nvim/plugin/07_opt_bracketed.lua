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

-- window mappings
vim.keymap.set('n', '[w', '<C-w>p', { desc = 'Previous window' })
vim.keymap.set('n', ']w', '<C-w>w', { desc = 'Next window' })
-- use arrow keys to move between windows
vim.keymap.set('n', '[<Up>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '[<Down>', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '[<Left>', '<C-w>h', { desc = 'Move to window left' })
vim.keymap.set('n', '[<Right>', '<C-w>l', { desc = 'Move to window right' })
-- also for terminal mode
vim.keymap.set('t', '[<Up>', '<C-\\><C-n><C-w>k', { desc = 'Move to window above' })
vim.keymap.set('t', '[<Down>', '<C-\\><C-n><C-w>j', { desc = 'Move to window below' })

-- tabpage mappings
--  [ pageup / ]pagedown
--  [ tabprev / ]tabnext
-- Tab navigation using brackets + Page Up/Down keys
vim.keymap.set("n", "[<PageUp>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "]<PageDown>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

--
