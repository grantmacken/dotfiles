return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  opts =  {},
  config = function(_,opts)
    require("copilot").setup(opts)
  end
}
