# Copilot Instructions for this repo

## What this is
Personal dotfiles for Fedora Silverblue (an atomic/immutable OS), deployed with
**GNU Stow**. There is no build system, package manifest, or test suite —
changes are validated by re-stowing and manually exercising the affected tool
(shell, nvim, git, etc.).

## Repo layout convention
Stow uses the `--dotfiles` flag, so top-level directories prefixed `dot-`
map to dotfiles/dirs in `$HOME` with the prefix converted to a leading `.`:
- `dot-config/**`  → `~/.config/**` (nvim, git, gh, fzf, npm, containers, systemd)
- `dot-local/bin`   → `~/.local/bin` (personal scripts)
- `dot-local/share` → `~/.local/share`
- `dot-bashrc.d/*.sh` → `~/.bashrc.d/*.sh` (sourced shell fragments: alias, completion, exports, misc, prompt)

When adding a new dotfile, put it under the matching `dot-*` directory using
the same `dot-` → `.` naming convention so Stow will symlink it correctly.
Files/dirs listed in `.stow-local-ignore` (README, LICENSE, Makefile, files,
latest, docs, okf, tmp, .arglist, .git, .github, .gitignore, .luarc.json,
.nvim.lua) are never symlinked by Stow — don't expect changes there to appear
in `$HOME`.

## Commands (Makefile)
Run from the repo root:
- `make` (or `make default`) — deploy: chmod +x on `dot-local/bin/*`, then
  `stow --dotfiles --target ~/ .` to symlink everything into `$HOME`.
- `make init` — create XDG base-dir scaffolding (`~/.local/bin`, nvim cache/state/data
  dirs, `~/.config/nvim` subtree) needed before first deploy.
- `make clean` — dry-run then real `stow --delete` to remove all symlinks.
- `make reset_nvim` — wipe nvim's cache/state/data dirs (not under Stow control)
  for a clean-slate Neovim restart.
- `make oldnvim` / `make minmax` — one-off helpers to copy in a legacy or
  MiniMax nvim config for comparison; not part of normal workflow.

There is no `make test`/`make lint`. To validate a change, re-run `make`
(safe/idempotent — Stow just re-links) and open the affected app (e.g. launch
`nvim` to check Lua config loads without error).

## Neovim config (`dot-config/nvim`)
- `init.lua` enables `vim.loader`, configures the native `ui2` message/cmdline
  system, disables several built-in plugins, and declares plugins via
  **`vim.pack.add`** (Neovim's built-in package manager, `gh:owner/repo`
  shorthand) — not lazy.nvim/packer. Add new plugins to this list.
- Plugin/user config lives under `lua/` in topic-named modules: `arglists`,
  `autocmds`, `commands`, `git`, `icons`, `keymaps`, `repo`, `search`,
  `sessions`, `show`, `templates`, `util`.
- `after/{ftplugin,lsp,snippets}` hold filetype/LSP/snippet overrides;
  `plugin/`, `snippets/`, `templates/`, `scripts/` follow standard Neovim
  runtime-path conventions.
- `_hold` is ignored by git — scratch/WIP files that shouldn't be committed.

## Shell scripts (`dot-local/bin`)
Scripts are plain bash with `set -euo pipefail`. Several (e.g.
`toolbox_recreate_container`) are toolbox/Ptyxis-aware: they detect whether
they're running inside a Fedora Toolbox container via `/run/.containerenv`
and use `host-spawn` to re-launch a host-side Ptyxis terminal/tab when an
operation (like recreating the container) must happen outside the container.
Keep this host/container distinction in mind when editing toolbox-related
scripts.

## Conventions to preserve
- Script/section output uses a light "banner" style, e.g.
  `echo '##[ some step ]##'` and a trailing `echo '✅ completed task'` —
  match this style in Makefile targets and bin scripts for consistency.
- Prefer XDG Base Directory variables (`$CONFIG_HOME`, `$CACHE_HOME`,
  `$DATA_HOME`, `$STATE_HOME`, `$BIN_HOME`) as already defined in the
  Makefile rather than hardcoding `~/.config`, `~/.cache`, etc.
