local ok, oil = pcall(require,'oil')
if not ok then return end
oil.setup({
    columns = {
    "icon",
  },
  skip_confirm_for_simple_edits = true,
  view_options = {show_hidden = true},
})
