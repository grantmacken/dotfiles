---
description: Sequentially clarify a Neovim Lua module's description, implementation checklist, and references
argument-hint: "<module-path>"
---
Work on the Neovim Lua module at `$1` using these three project skills in this exact order:

1. `lua-module-description`
2. `lua-module-implementation`
3. `lua-module-references`

Read each skill file before using it:
- `.pi/skills/lua-module-description/SKILL.md`
- `.pi/skills/lua-module-implementation/SKILL.md`
- `.pi/skills/lua-module-references/SKILL.md`

## General rules

- Inspect the target module, neighboring modules, callers, tests, and relevant startup files before asking questions.
- Preserve existing user wording and completed checklist items unless the user asks to change them.
- Ask only one focused question at a time.
- Do not invent APIs, callers, features, or references.
- Do not edit until the user approves the proposed block for the current phase.
- After approval, change only the metadata block owned by that phase.
- Keep the work focused on module metadata; do not rewrite implementation code.

## Phase 1: description

Use `lua-module-description` to clarify only:
- overview: what the module does and why it exists
- scope: what it owns and does not own
- usage: how callers use its public API

Present a concise proposed `M.description` block and request approval. After approval,
replace only that block, then continue to Phase 2.

## Phase 2: implementation

Use `lua-module-implementation` to maintain a short `M.implementation` checkbox list.
- Confirm each new or revised item with the user.
- Keep every item under 120 characters.
- Mark items complete only when code or the user confirms completion.
- Do not duplicate the description or create speculative subtasks.

Present the complete proposed checklist and request approval. After approval, replace
only `M.implementation`, then continue to Phase 3.

## Phase 3: references

Use `lua-module-references` to build a short navigable `M.references` list.
- Keep URLs `gx`-navigable and local paths relative to the module file for `gf`.
- Preserve existing relevant links.
- For public APIs, inspect actual callers in the relevant `plugin/` files, especially
  `10_user_commands.lua`, `11_keymaps.lua`, and `12_autocommands.lua`.
- Include relevant tests, generated artifacts, and Neovim documentation only when they
  are useful navigation targets.
- Confine caller searches to the directory or scope requested by the user.

Verify local paths resolve from the module file, present the proposed references, and
request approval. After approval, replace only `M.references`.

At the end, report the three metadata blocks changed and any validation performed.
