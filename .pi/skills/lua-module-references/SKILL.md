---
name: lua-module-references
description: Maintain the simple M.references list for a Neovim Lua module. Keep relevant entries as URLs or relative file paths that Neovim can open with gx or gf.
---

# Maintain module references

Use `M.references` as a small navigation list for sources that explain or
support the module. It is not a bibliography and should not contain prose.

## Rules

- Keep one URL or file path per list item.
- Use `gx`-navigable URLs for web references.
- Use `gf`-navigable relative paths for local files.
- Keep local file references relative to the module being edited; do not use absolute paths, repo-root-relative paths, or `$HOME`.
- Prefer paths that exist in this repository or the Neovim configuration.
- Keep references directly relevant to the module's behavior, API, or design.
- For public API modules under `lua/`, include the actual startup-side callers under `plugin/` when they exist, especially `10_user_commands.lua`, `11_keymaps.lua`, and `12_autocommands.lua`.
- Prefer direct caller references over generic resolver internals unless the resolver is itself part of how callers reach the module API.
- Include related tests and generated artifacts only when they are directly useful navigation targets for understanding or validating the module.
- Preserve existing relevant references; remove only placeholders, duplicates, and stale references.
- Do not add a reference merely because it was consulted during coding.

A valid section looks like:

```lua
M.references = [[
 - https://neovim.io/doc/user/lua.html
 - buf.lua
 - ../../plugin/10_user_commands.lua
 - ../../tests/test_show_snapshots.lua
]]
```

## Dialog workflow

1. Read the module and its callers to identify the boundaries and APIs that need
   navigation references. For public Neovim modules, inspect the relevant
   `plugin/` startup files for actual command, keymap, and autocommand usage.
2. Inspect the existing `M.references` list for placeholders, duplicates, and
   stale paths.
3. Ask focused questions when it is unclear whether a source is relevant or
   what relative path should be used.
4. Add only confirmed URLs or relative file paths.
5. Before editing, check that local paths resolve from the module file with `gf`
   and that URLs are complete enough for `gx`. When choosing caller links,
   confine the search to the area the user asked about instead of adding broader
   infrastructure files by default.
6. When approved, change only the `M.references` block.

Keep the list short. The module description explains purpose and usage; the
implementation checklist tracks work; this section only provides navigable
pointers.
