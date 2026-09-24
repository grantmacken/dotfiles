# Dotfiles project instructions

## Scope

This repository contains personal Fedora Silverblue dotfiles deployed with GNU Stow.
Treat it as configuration, not an application: preserve existing user settings and
avoid committing machine-specific state, credentials, generated files, or sessions.

## Layout

- `dot-config/` becomes `~/.config/` with Stow's `--dotfiles` mode.
- `dot-bashrc.d/` becomes `~/.bashrc.d/` and contains sourced shell fragments.
- `dot-local/bin/` becomes `~/.local/bin/` and contains executable scripts.
- Pi's global configuration is under `dot-config/pi/agent/`.
- `.pi/` contains project-local Pi resources and is intentionally not deployed.

## Validation

- Run `make` to deploy changes through Stow.
- Use `stow --simulate --verbose --dotfiles --target "$HOME" .` to inspect links
  without changing the home directory.
- For shell changes, run `bash -n` on affected scripts.
- For Neovim changes, launch Neovim and check for startup errors.

## Commits
- Use Pure Scoped Commits (Subsystem Prefixing) without rigid Conventional Commit types. 
- Prefix the commit summary with the component, tool, or module being changed (e.g., `ptyxis:`, `nvim:`, `bash:`).
- Keep the summary imperative and concise.

Keep changes focused, follow the existing shell/Lua style, and report validation
performed along with any remaining uncertainty. When creating or changing a Lua
module, load the project `lua-module` skill for the module-specific conventions.
When clarifying a module's `M.description`, load the project
`lua-module-description` skill and use its focused, one-question-at-a-time
workflow. When maintaining a module's `M.implementation` checklist, load the
project `lua-module-implementation` skill. When maintaining a module's
`M.references` list, load the project `lua-module-references` skill.
When converting callback-based Lua or Neovim APIs, also load the project
`async-wrap` skill and verify the signatures against the installed development
build.
