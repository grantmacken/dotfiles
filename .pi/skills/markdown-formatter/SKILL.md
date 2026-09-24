---
name: markdown-formatter
description: Format raw data, arrays, or JSON into visually pleasing Markdown tables, checklists, or nested lists. Use when creating UI outputs, logging structures, or building Markdown representations of Lua or CLI results.
---

# Markdown Formatter Skill

This skill provides guidelines for transforming raw data—such as command-line outputs, JSON responses, or Lua table iterations—into clean, readable, and visually pleasing Markdown structures.

## 1. Markdown Tables (For Structured/Tabular Data)
When formatting multiple items that share the same attributes (e.g., processes, server lists, environment variables, or tool outputs):

- **Dynamic Column Widths:** 
  Always calculate the maximum string length of the data in each column before constructing the table. 
- **Padding:** 
  Pad the content in the rows using format strings (e.g., `%-10s`) so that the raw text aligns vertically. This makes the Markdown source just as readable as the rendered output.
- **Headers:** 
  Ensure headers are capitalized and the separator row uses the exact width of the column content (e.g., `|----------|`).

### Lua Implementation Example:
```lua
-- 1. Calculate max widths
local max_id = 2 -- "ID"
local max_name = 4 -- "Name"
vim.iter(data):each(function(t)
  max_id = math.max(max_id, string.len(tostring(t.id)))
  max_name = math.max(max_name, string.len(t.name))
end)

-- 2. Build header
local md = {
  string.format("| %-" .. max_id .. "s | %-" .. max_name .. "s |", "ID", "Name"),
  string.format("|-%s-|-%s-|", string.rep("-", max_id), string.rep("-", max_name))
}

-- 3. Build rows
vim.iter(data):each(function(t)
  table.insert(md, string.format("| %-" .. max_id .. "d | %-" .. max_name .. "s |", t.id, t.name))
end)
```

## 2. GitHub Task Checklists (For State or TODOs)
When outputting data that represents boolean states, tasks, or configuration flags, use GitHub-flavored task lists.

- **Completed:** `- [x] Task name`
- **Incomplete:** `- [ ] Task name`

**Best Practices:**
- If rendering from a script, map boolean `true` to `[x]` and `false` to `[ ]`.
- Align the text if the task descriptions are short and tabular, otherwise, allow them to flow naturally.

## 3. Nested Lists (For Hierarchical Data)
When formatting trees, file structures, or nested JSON configurations, use standard nested bullet points.

- **Indentation:** Use exactly 2 spaces for each level of indentation.
- **Bullets:** Use `-` as the primary bullet character for consistency.
- **Highlighting:** Use inline code blocks (`\``) for keys, file names, or specific values to make them visually pop.

### Example:
```markdown
- `app`
  - `controllers`
    - `user.ts` (Active)
  - `models`
- `config`
  - `database.json`
```

## 4. Quotations and Callouts (For Meta-Information)
When formatting logs, warnings, or metadata that applies to the entire dataset (e.g., descriptions, timestamps, or execution contexts), use Markdown blockquotes.

- **Standard Callouts:** Use `> ` to prefix the line.
- **Visual Separation:** Leave a blank line before and after the blockquote to ensure it doesn't bleed into lists or tables.
- **Metadata Framing:** When script output needs to tell the user *how* the data was generated, put it in a quote block at the top.

### Example:
```markdown
> **Generated on:** 2023-10-25 14:00:00
> **Command:** `nvim --server /tmp/sock --remote-expr ...`

| Addr | PID |
|------|-----|
```

## Workflow
When asked to format data into Markdown:
1. Identify the shape of the data (Tabular = Table, State = Checklist, Hierarchical = Nested List).
2. If generating Lua/Bash code to produce the Markdown, ensure the code dynamically calculates padding for tables as defined in Section 1.
3. Return the formatted Markdown or the script that generates it.
