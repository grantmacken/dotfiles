-- for _, disable in ipairs({ "gzip", "netrwPlugin", "tarPlugin", "zipPlugin" }) do
--   vim.g["loaded_" .. disable] = 0
-- end
local providers = { "perl", "ruby", "python", "python3" }
for _, provider in ipairs(providers) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end
