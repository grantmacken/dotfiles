local ok, chat = pcall(require, "CopilotChat")
if not ok then 
  vim.print("CopilotChat is not installed")
  return 
end
-- Copilot autosuggestions
vim.g.copilot_no_tab_map = true
vim.g.copilot_hide_during_completion = 0
vim.g.copilot_proxy_strict_ssl = 0

-- vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })


local user = vim.env.USER or 'User'
user = user:sub(1, 1):upper() .. user:sub(2)

local actions = require('CopilotChat.actions')
local select = require('CopilotChat.select')
local integration = require('CopilotChat.integrations.fzflua')

--h: CopilotChat-default-configuration*
local opts = {
  model = "claude-3.5-sonnet",
  auto_insert_mode = true,
  question_header = "  " .. user .. " ",
  answer_header = "  Copilot ",
  error_header = "  Error ",
  selection = select.visual,
 }
-- TODO check mappings
chat.setup(opts)

 vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
            vim.opt_local.relativenumber = true
            -- C-p to print last response
            vim.keymap.set('n', '<C-p>', function()
              print(require("CopilotChat").response())
            end, { buffer = true, remap = true })
        end
    })

--
--fzf-lua integration
local nLeader = require('keymaps').nLeader
local nvLeader = require('keymaps').nvLeader
nLeader('ap', function()integration.pick(actions.prompt_actions())end,"CopilotChat Fzf Prompt" )
nLeader('aa',chat.toggle,"CopilotChat Toggle")
nLeader('ax',chat.reset,"CopilotChat Reset")
nLeader('as',chat.stop,"CopilotChat Stop")

nvLeader('aq', function()
 vim.ui.input({
    prompt = 'AI Question> ',
  }, function(input)
    if input and input ~= '' then
      chat.ask(input)
    end
  end)
end,'AI Question')


--[[

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}
]]--
