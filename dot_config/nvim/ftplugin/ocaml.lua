local log = require('my.util').log
log('fileype opened:  lua ')
local language_id_of = {
  menhir = 'ocaml.menhir',
  ocaml = 'ocaml',
  ocamlinterface = 'ocaml.interface',
  ocamllex = 'ocaml.ocamllex',
  reason = 'reason',
  dune = 'dune',
}
local get_language_id = function(_, ftype)
  return language_id_of[ftype]
end

local onInit = function(client, _)
  log('client' .. client)
end

local root_dir = vim.fs.dirname(vim.fs.find(
{ '*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace' }, { upward = true })[1])
vim.lsp.start({
  name = 'ocamllsp',
  cmd = { 'ocamllsp' },
  on_init = onInit,
  filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
  root_dir = root_dir,
  get_language_id = get_language_id
})
