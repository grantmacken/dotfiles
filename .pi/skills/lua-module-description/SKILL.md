---
name: lua-module-description
description: Iteratively clarify the brief M.description for a Neovim Lua module created from templates/lua_module.lua. Use when developing or revising a module description, especially its overview, scope, and usage. Ask focused questions based on the module and its callers; do not invent speculative features.
---

# Clarify a Lua module description

Help the user produce a short, accurate `M.description` for a module under
`dot-config/nvim/lua`. This is a focused grill-me process, not a brainstorming
or design exercise.

## Source of truth

Use the description outline from `dot-config/nvim/templates/lua_module.lua`:

```lua
M.description = [[
 A brief plan outline of what the module will achieve.
 - overview: module overview which describes the module's purpose and functionality
 - scope: module scope
 - usage: how to use the module
]]
```

Clarify only these three items:

- **Overview:** What the module does and why it exists.
- **Scope:** What the module owns, and what it deliberately does not own.
- **Usage:** How another module, plugin startup file, command, keymap, or
  autocommand calls its public API.

## Grill-me workflow

1. Inspect the target module, neighboring modules, and its callers before asking
   questions. Use `rg` to find `require()` calls and exported `M.` functions.
2. If the module is new and mostly contains the template, ask what concrete
   existing task or configuration it will support. Do not propose unrelated
   features.
3. Ask one focused question at a time. Start with the least clear item among
   overview, scope, and usage.
4. Ground each question in code or an observed caller, for example:
   - “`plugin/11_keymaps.lua` calls `keymaps.set`; is installing declarative
     keymaps the complete responsibility of this module?”
   - “The module exposes `show.data` and `show.run`; should its scope include
     creating/reusing the show window, or only managing buffers?”
5. Reflect the user's answer briefly, update the draft, and ask the next
   question. Do not fill gaps with imagined behavior.
6. When all three items are clear, present a concise proposed description and
   ask for approval before editing the module.
7. After approval, replace only the `M.description` block. Preserve
   `M.version`, `M.implementation`, `M.references`, code, formatting style, and
   any user wording that remains accurate.

## Output requirements

The final description should:

- Be brief: normally 3–8 lines inside the long string.
- Describe current or explicitly intended behavior, not aspirations.
- Name important public entry points when that makes usage unambiguous.
- State boundaries when the module could be confused with a neighboring module.
- Avoid repeating implementation details that callers do not need to know.
- Avoid adding TODOs, references, or design decisions to `M.description`; those
  belong in their dedicated template fields.

A suitable final shape is:

```lua
M.description = [[
 Manage named buffers displayed in the per-tab show window.
 - overview: creates or reuses the show window and routes data to named buffers
 - scope: owns show-window buffer/channel coordination; does not define user keymaps
 - usage: require('show') and call show.data(bufName, data, opts) or show.run(bufName, cmd)
]]
```

## Guardrails

- Do not turn this into a feature-planning session.
- Do not infer APIs that are not present in the module or its callers.
- Do not rewrite the implementation while clarifying the description.
- If the code and the user's intended behavior disagree, identify the mismatch
  and ask which should be treated as authoritative.
