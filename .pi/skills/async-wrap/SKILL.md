---
name: async-wrap
description: Convert callback-style Lua and Neovim APIs into structured asynchronous code using vim.async.wrap. Use when refactoring functions that accept callbacks, especially vim.system, vim.uv, timers, filesystem APIs, and other event-loop operations in this Neovim development configuration.
---

# Convert callbacks to `vim.async`

Refactor callback-based code into structured async tasks without blocking
Neovim's event loop.

## Core rules

- Target the local Neovim development build. Read its runtime help before
  assuming an API signature:
  `help vim.async`, `help vim.async.wrap`, and the API's own help tag.
- Use `vim.async.wrap(argc, func)` when the callback adaptation is reusable.
  `argc` is the 1-based argument position at which the callback is inserted.
- Use `vim.async.await(...)` directly for a one-off adaptation.
- Start work with `vim.async.run(function() ... end)` unless the caller is
  already running inside an async task.
- Never block an async task with `vim.wait`, `SystemObj:wait()`, or equivalent
  synchronous waits. Await the operation instead.
- Preserve the source API's callback result order and error convention. Do not
  silently turn an error-first callback into a successful result.
- Prefer `vim.async.pawait(...)` when an awaited operation may fail and the task
  should handle the failure instead of aborting.

## Refactoring workflow

1. Read the original function and the local runtime help for its callback
   signature.
2. Identify the callback argument position, including optional arguments.
3. Check whether the returned handle is closable. `vim.async.wrap` can close a
   closable return value when the owning task is cancelled.
4. Replace callback nesting with a wrapped function or a direct `await`.
5. Preserve cancellation, cleanup, error handling, and result ordering.
6. Keep UI updates and Neovim API calls on the main scheduled context as
   required by the API.
7. Validate with headless Neovim and inspect the relevant help after editing.

## Reusable wrapper

For a callback API whose callback is argument 3:

```lua
local async = vim.async
local system = async.wrap(3, vim.system)

local function run_command(command)
  return system(command, { text = true })
end

async.run(function()
  local result = run_command({ "git", "status", "--short" })
  if result.code ~= 0 then
    log.error("command failed", result.code, result.stderr)
    return
  end
  log.debug("command output", result.stdout)
end)
```

The callback's arguments become the wrapped function's return values. For an
error-first callback such as `vim.uv.fs_stat`, retain and check the error:

```lua
local async = vim.async
local fs_stat = async.wrap(2, vim.uv.fs_stat)

async.run(function()
  local err, stat = fs_stat(path)
  if err then
    log.error("stat failed", err)
    return
  end
  use_stat(stat)
end)
```

Do not guess the position. Verify it from the local help. If an API has an
optional argument before the callback, callers may need to pass that argument
explicitly so the callback lands at the wrapped position.

## One-off adaptation

Use `await` when creating a named wrapper would add no value:

```lua
async.run(function()
  local err, stat = async.await(2, vim.uv.fs_stat, path)
  if err then
    log.error("stat failed", err)
    return
  end
  use_stat(stat)
end)
```

`async.await` accepts either a callback-taking function plus its arguments, or
an argument position followed by the function and its arguments. Use the form
that matches the local runtime documentation.

## Errors and cancellation

- Decide whether failure should abort the task (`await`) or be handled locally
  (`pawait`).
- Preserve error-first results such as `err, value`; do not treat `err` as the
  value.
- Do not detach work merely to avoid handling cancellation. Use `:detach()` only
  when the operation intentionally outlives its parent task.
- Do not swallow errors in callbacks or add a notification in place of proper
  error handling. Use the module's `vim.log.new()` logger for diagnostics and
  reserve `vim.notify` for user-facing messages.
- Ensure resources owned by the operation are closed on cancellation. Prefer
  APIs that return closable handles and let `vim.async` manage them.

## Validation

Run a syntax check where practical, then exercise the code with the configured
Neovim development build:

```bash
nvim --headless -u NONE \
  +'lua io.stdout:write(vim.fn.execute("help vim.async.wrap"))' \
  +qa

nvim --headless -u path/to/init.lua \
  +'lua require("module").test()' \
  +qa
```

Check for leaked callbacks, failed cancellation, incorrect result ordering, and
errors that only appear after the event loop resumes.
