---
name: readme-clarifier
description: Clarify and refine README markdown files. Summarizes unformed ideas to confirm interpretation, uses harper-ls/harper-cli for grammar and spelling, and identifies where bullet points and tables can visually clarify content.
---

# README Clarifier

This skill helps users crystallize their ideas when writing a `README.md` (or other markdown documentation) by acting as an active listener and editor.

## 1. Summarize and Confirm
Often, a user's initial ideas are not fully formed. Before making large edits:
- **Read** the current draft or the user's raw input.
- **Summarize** what you believe they are trying to say in your own words.
- **Ask** the user if your interpretation is correct (e.g., "Is this what you meant?").
- Wait for the user's confirmation or adjustments before proceeding to finalize the text.

## 2. Grammar and Spell Check
The user explicitly requested using `harper-ls` (or its command-line equivalent, `harper-cli`) for grammar and spell checking.
- If the CLI tool is available, run it against the markdown file:
  ```bash
  harper-cli "path/to/README.md"
  ```
- Review the diagnostics provided by Harper and incorporate the necessary grammar, spelling, and style fixes into the text. 
- If the tool cannot be run in the current environment, perform a manual grammar and spell check, keeping Harper's strict but helpful style in mind.

## 3. Visual and Structural Clarity
Dense paragraphs are hard to read. Actively look for opportunities to improve visual clarity:
- **Bullet Points:** Convert comma-separated lists, sequential steps, or dense explanatory paragraphs into concise bulleted or numbered lists.
- **Tables:** Identify structured data, comparisons, environment variables, or configuration options and format them as Markdown tables.
- Briefly explain to the user why these structural changes were made to improve scanability.

## Workflow
1. User provides a draft or a stream-of-consciousness explanation of a project/feature.
2. You reply with a concise summary and ask for confirmation.
3. Once confirmed, you run `harper-cli` on the file (if applicable) and rewrite the content applying grammar fixes, bullet points, and tables.
4. Use the `edit` or `write` tool to update the file, and present the final polished version to the user.
