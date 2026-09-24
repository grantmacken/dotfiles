---
name: lua-module-implementation
description: Maintain the simple M.implementation checkbox list for a Neovim Lua module. Use it to discuss what the module has achieved and what remains, keeping each task under 120 characters and suitable for GitHub issue tracking.
---

# Clarify a module implementation checklist

Use `M.implementation` as a short dialog about the module's current state and
possible next work. It is not a detailed implementation plan and should not
become a design document.

## Rules

- Keep the list simple: one checkbox per task.
- Each checkbox text must be no more than 120 characters.
- Use `- [ ]` for unfinished work and `- [x]` for work that is complete.
- Describe concrete behavior, fixes, or decisions rather than implementation
  steps.
- Keep tasks useful as possible GitHub issue titles or issue descriptions.
- Do not split one small task into artificial subtasks.
- Do not add speculative blue-sky features.
- Do not duplicate the module description's overview, scope, or usage.
- Preserve completed items unless the user asks to archive or remove them.

## Dialog workflow

1. Read the module, its callers, and the existing `M.implementation` list.
2. Summarize what the module already achieves in plain language.
3. Ask one focused question at a time about an incomplete item or a clear gap.
4. Add or revise a checkbox only after the user confirms its meaning.
5. Mark an item `[x]` only when the code or the user confirms it is complete.
6. Periodically show the complete checklist so it remains a shared view of
   progress.
7. When the user approves the result, update only the `M.implementation` block.

## Checklist quality

A good item is specific enough to track but short enough to scan:

```lua
M.implementation = [[
 - [x] Reuse the existing show window for named buffers.
 - [ ] Handle cancellation when an async command is interrupted.
 - [ ] Add tests for empty command output.
]]
```

Before writing an item, check that its checkbox text is at most 120 characters.
If a task is too large, clarify its boundary with the user rather than creating
an implementation plan with many steps.

## GitHub tracking

Write items so they can become GitHub issues without substantial rewriting:

- Start with a verb when describing unfinished work: `Handle`, `Add`, `Fix`,
  `Document`, or `Remove`.
- Mention the affected behavior or boundary.
- Avoid internal step-by-step instructions.
- Keep the checkbox list as the module's lightweight progress record; issue
  details belong in GitHub when the work is actually opened.
