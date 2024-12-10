  -- Registers copilot-chat filetype for markdown rendering
local ok, render_markdown = pcall(require,'render-markdown')
if not ok then return end
render_markdown.setup({
  file_types = { 'markdown', 'copilot-chat' },
})
