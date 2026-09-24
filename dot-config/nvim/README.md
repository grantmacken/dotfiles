# Neovim configuration organisation

This configuration separates reusable Lua modules from startup configuration.
Files under `plugin/` are loaded by Neovim during startup in filename order;
the numeric prefixes make the intended order explicit.

## Design principle

- `lua/` contains the reusable implementation and public APIs.
- `plugin/` is the composition/root layer. It calls module APIs and configures
  Neovim, rather than being the primary home for reusable module logic.
- `plugin/` should describe *what is enabled and how it is wired together*;
  `lua/` should implement *how the feature works*.
- Keep concerns separate: options, commands, keymaps, autocommands, plugin
  setup, diagnostics, LSP setup, and feature-specific wiring each have a
  focused startup file.

A module normally lives at `lua/<name>/init.lua`, returns a public table named
`M`, and may have focused submodules below it. For example, the `show` API is
split into `show/{init,buf,chan,util,win}.lua`. Consumers load it with
`require('show')` and use its exported functions; startup files should not
reimplement those functions.

## Startup files

Neovim sources the files in `plugin/` in lexical order:

| File | Responsibility |
| --- | --- |
| `00_globals.lua` | Global variables, leader keys, and the default colorscheme. |
| `01_options.lua` | General editor, terminal, window, editing, clipboard, undo, and display options. |
| `02_opt_find.lua` | File-search options and the custom `findfunc` implementation. |
| `03_opt_grep.lua` | `rg`-based `grepprg` and `grepformat` configuration. |
| `04_opt_complete.lua` | Insert and command-line completion options. |
| `05_opt_folds.lua` | Folding options and the LSP fold expression. |
| `06_opt_search.lua` | Search behavior and incremental substitution settings. |
| `10_user_commands.lua` | User-command declarations, using the `commands` module to resolve command names to module functions. |
| `11_keymaps.lua` | Global keymaps, expressed as data and installed through the `keymaps` module. |
| `12_autocommands.lua` | Startup autocommands, expressed as data/callbacks and installed through the `autocmds` module. |
| `13_templates.lua` | The `BufNewFile` template hook for new Lua modules. |
| `19_mini.lua` | Configuration for the enabled `mini.*` modules and their LSP completion capabilities. |
| `20_diagnostics.lua` | Diagnostic signs, display configuration, and `tiny-inline-diagnostic` setup. |
| `21_lsp.lua` | LSP server enabling and buffer-local LSP behavior on attach/detach. |
| `30_show.lua` | Temporary `show` API test wiring; planned for removal once the feature is wired through normal startup files. |

The gaps in the numbering leave room for related configuration to be inserted
without renaming existing startup files.

Note: `plugin/30_show.lua` is a temporary testing file. Reusable `show`
implementation belongs under `lua/show/`, automated tests belong under
`tests/`, and user-facing commands to run those tests belong in
`plugin/10_user_commands.lua`.

## Where to put new code

### Reusable behavior: `lua/`

Add or extend a module under `lua/` when the code provides behavior that can be
called by commands, keymaps, autocommands, or other modules. Keep the public API
small and document public parameters and return values. Use the project
`lua-module` skill when creating or changing a module.

Examples include:

- `commands`: resolve the command naming convention and register commands.
- `keymaps`: install keymaps from declarative tables.
- `autocmds`: install callback- or command-based autocommands.
- `git`, `search`, `sessions`, and `templates`: feature APIs used by startup wiring.
- `show`: manage named buffers, channels, and the dedicated show window.
- `util`: shared helper functions.

### Startup wiring: `plugin/`

Add code to `plugin/` when it configures Neovim at startup or connects a module
API to a user-facing entry point:

- Set options in the appropriate `*_opt_*.lua` file.
- Add user commands in `10_user_commands.lua` or a focused later file when the
  command is feature-specific.
- Add global keymaps in `11_keymaps.lua`; keep the mapping data readable.
- Add autocommands in `12_autocommands.lua` or a focused feature file when
  appropriate.
- Configure third-party plugins in their focused startup file.
- Keep LSP lifecycle behavior in `21_lsp.lua` and diagnostics display in
  `20_diagnostics.lua`.

Feature-specific startup files may call several APIs, but the implementation
belongs in `lua/` when it is more than small configuration glue.

## Other runtime directories

- `after/` contains runtime overrides loaded after normal runtime files.
- `lsp/` contains per-server Neovim LSP configuration.
- `templates/` contains files inserted by the template autocommand.
- `init.lua` is the minimal entry point that establishes the base runtime and
  plugin declarations before the `plugin/` files are sourced.

## Validation

After changing startup Lua, launch the configured development Neovim build and
check for startup errors. For a lightweight check, use:

```bash
nvim --headless -u init.lua +qa
```

For module changes, also exercise the public API or inspect its local help and
use the project `async-wrap` skill when converting callback-based APIs.

<!-- coding conventions:
  local function names: should be in readable snake_case
  variable names: readable at a glance predefined variable names should be in camelCase
    handles to a nvim objects should be
       - camelCase with a suffix of ID
       - e.g bufID - read as 'this buffer has this ID'
    NOTE: the at a glance ID type variable is allways a number the may identify the nvim object

    scoped identifiers should camelcase with a scope prefix and a identifier e.g. bufname, buftype, oheight, oenter, olisted, oscratch
       1. scoped types: e.g. `buftype` - read as 'this buffer has this type'
       2. scoped names e.g.  `bufname` - read as 'this buffer has this name'
       3. scoped options e.g. `oheight` - read as 'this option has this height'
       4. scoped return values e.g. `ostdout` - read as 'this option has this stdout'

  module function names: should be in camelcase
  parameter names passed in function: should be camelcase e.g.
  ```
  local has_channel = function(bufID)
 ``

  function returns:
   prefix is_{this} _has_{what}  etc.  are boolean returns
   example: `get_bufid(bufname)` returns a numeric buffer id handle for the named buffer, or zero on failure
   prefix set_{this} are string returns with an empty string failure to set the value
   example: `set_buf_type` re:turns a bufType string or empty string on failure

  A bufName is a string that identifies a buffer by a bufType followed by a CamelCase name.
  examples: bufScratchDefault, bufShellBuild, bufTaskTest, bufEditNotes
  bufNames are used to identify unique buffers that can be shown in the `show` window.
  bufType is parsed from a bufName and is is one of: bufScratch, bufShell, bufTask, bufEdit

-->
