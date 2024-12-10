local ok, chat = pcall(require,'CopilotChat')
if not ok then return end
local user = vim.env.USER or 'User'
user = user:sub(1, 1):upper() .. user:sub(2)
chat.setup({
    auto_insert_mode = true,
    question_header = "  " .. user .. " ",
    answer_header = "  Copilot ",
    window = {
      width = 0.4,
    },
 })
