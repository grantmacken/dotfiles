---
name: lua-module
description: Create or modify Lua modules in this Neovim dotfiles project. Use when working under dot-config/nvim/lua, especially when creating a new module or deciding its structure, naming, documentation, and Neovim API usage.
---

# Neovim Lua module style

## Module layout

- Put modules under `dot-config/nvim/lua/<module>/`.
- Use `init.lua` for the module entry point; use additional files for cohesive
  subcomponents, as in `show/{init,buf,chan,util,win}.lua`.
- Return a public module table named `M`.
- Keep module-specific implementation local and expose only the functions that
  other modules need.
- Use `require("module")` for project modules and keep related requires near
  the top of the file, before implementation code.

## Module header

New modules should begin with the established metadata shape:

```lua
local M = {}
M.version = "0.1.0"
M.description = [[
 Module purpose and behavior.
 - overview: what the module does
 - scope: what it owns
 - usage: how callers use it
]]

M.implementation = [[
 - [ ] follow-up work
]]

M.references = [[
 - relevant issue, discussion, or local file
]]
```

Keep metadata useful and specific. Do not retain placeholder TODOs or references
when they are not meaningful for the new module.

## Naming and functions

- Use readable `snake_case` for local helper functions.
- Use `camelCase` for public functions on `M` and for function parameters.
- Use readable local variable names; use the existing `bufID`, `winID`, `chanID`
  convention for Neovim numeric object handles.
- Use scope-prefixed names for related values where useful (`bufName`, `bufType`,
  `oheight`, `ostdout`).
- Prefer `local function name(...)` for private helpers when it improves
  readability; use `M.name = function(...)` for public functions.
- Use `---@param` and `---@return` annotations for public functions, ambiguous
  values, and tables whose shape matters.
- Return explicit failure values consistent with the surrounding module. For
  example, numeric Neovim handles use `0` on failure and boolean predicates use
  boolean results.

## Neovim conventions

- Target the latest Neovim development version used by this configuration,
  not merely the latest stable release. Prefer APIs documented by that build
  over compatibility shims or deprecated functions.
- For asynchronous work, prefer the development API in `vim.async` and consult
  the local runtime help for its current interface. Use `vim.uv` or other
  lower-level APIs only when appropriate. Do not introduce older job/channel
  wrappers when a current API provides the needed behavior.
- Use `vim.async.wrap(argc, func)` to adapt reusable callback-style APIs such as
  `vim.system` into awaitable functions. This avoids callback nesting while
  preserving callback return values and gives `vim.async` a closable handle to
  cancel when the owning task is closed. Use `vim.async.run` for the task and
  `vim.async.await`/the wrapped function inside it; do not block with `:wait()`
  from async code.
- Use the file-backed `vim.log` API for module diagnostics. Create a named
  logger with `vim.log.new({ name = 'module-name', level = vim.log.levels.DEBUG })`
  and use its `trace`, `debug`, `info`, `warn`, and `error` methods. Reserve
  `vim.notify` for messages that intentionally belong in the user interface;
  do not use it as the module's general logging mechanism or use ad-hoc
  `print` calls.
- Check the installed Neovim help and `:news` before relying on an unfamiliar
  or version-sensitive API. If the local runtime disagrees with memory or an
  external example, follow the local runtime.
- Use `vim.notify` for user-visible failures and include enough context to act
  on the error.
- Guard fallible operations with `pcall` where a Neovim API or external module
  can fail; handle the error instead of silently discarding it.
- Keep keymaps, commands, autocommands, and plugin setup in their existing
  topic modules unless the new module owns that behavior.
- Follow the existing formatting and quote style in the neighboring module.

## Creation workflow

1. Inspect neighboring modules and callers before choosing the API.
2. Create `dot-config/nvim/lua/<module>/init.lua` using the layout above.
3. Add only the public API required by callers.
4. Wire the module into the appropriate `plugin/` or topic module if needed.
5. Check the Lua syntax and launch Neovim to catch startup/runtime errors.
6. Report the module path, public API, and validation performed.
