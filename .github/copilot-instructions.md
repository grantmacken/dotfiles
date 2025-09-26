
# GitHub Copilot Instructions: Dotfiles Repository

## Repository Overview

This is a **personal dotfiles repository** for customizing a Fedora Silverblue (atomic Linux) development environment. The repository provides a CLI-focused toolbox environment centered around Neovim, containerization with Podman/Toolbox, and automated AI agent workflows for spec-driven development.

**Repository Type**: Configuration/Dotfiles  
**Primary Languages**: Bash (scripts), Lua (Neovim config)  
**Size**: Medium (~100 files, mostly configuration)  
**Target Platform**: Fedora Silverblue with Podman Toolbox containers  
**Main Tools**: Stow, Make, Git, Bash, Lua, Podman, Neovim  

## Build and Setup Instructions

### Prerequisites
**Required Tools**: 
- `git` (version control)
- `make` (build orchestration) 
- `stow` (symlink farm manager) - **CRITICAL**: Main build will fail without this
- `bash` (shell scripting)
- `podman` (containerization)
- `toolbox` (development containers)
- `dconf` (GNOME configuration)

### Build Commands

#### Bootstrap Setup
```bash
# ALWAYS run this first to create required directories
make init
```
**Time**: <5 seconds  
**Creates**: `~/.local/share/nvim`, `~/.cache/nvim`, etc.

#### Main Installation
```bash 
# Main command to symlink all dotfiles using stow
make
```
**Equivalent to**: `make default`  
**Time**: 5-10 seconds  
**Requires**: `stow` must be installed  
**Effect**: Creates symlinks from repository to `~/` using stow  
**CRITICAL**: This will fail with "command not found" if stow is not installed

#### Cleanup  
```bash
# Remove all symlinked dotfiles
make delete
```
**Time**: <5 seconds

#### Neovim Reset
```bash
# Clean Neovim state and reinstall
make clean_nvim
```
**Time**: 5-10 seconds

#### AI Tools Setup
```bash  
# Install spec-driven development CLI tools
make ai
```
**Installs**: `uv` and `specify-cli` from GitHub

### Key Scripts

#### Toolbox Management
```bash
# Reset and configure development toolbox container
./dot-local/bin/tbx-reset
```
**Purpose**: Pulls latest container image, configures Ptyxis terminal  
**Time**: 30-60 seconds depending on image pull

#### Agent Context Updates
```bash
# Update AI agent context files (run exactly as shown)
./.specify/scripts/bash/update-agent-context.sh copilot
```
**Purpose**: Updates `.github/copilot-instructions.md` and other agent files  
**IMPORTANT**: Execute exactly as specified above - do not add or remove arguments

## Project Architecture

### Directory Structure

```
/
├── .github/                    # GitHub configuration
│   └── prompts/               # AI agent prompts
├── .specify/                   # Spec-driven development framework
│   ├── scripts/bash/          # Automation scripts
│   └── templates/             # Template files
├── dot-bashrc.d/              # Bash configuration fragments  
├── dot-config/                # XDG config directory (~/.config)
│   ├── nvim/                  # Neovim configuration (Lua)
│   ├── gh/                    # GitHub CLI config
│   └── containers/systemd/     # Podman Quadlet configs
├── dot-local/                 # Local user directory (~/.local)
│   └── bin/                   # Custom scripts and tools
├── Makefile                   # Build orchestration
└── README.md                  # Basic documentation
```

### Configuration Management Strategy

**Stow-based**: Repository uses GNU Stow with `--dotfiles` flag to manage symlinks:
- `dot-config/` → `~/.config/`  
- `dot-local/` → `~/.local/`
- `dot-bashrc.d/` → `~/.bashrc.d/`

### Neovim Configuration (dot-config/nvim/)

**Language**: Lua (LuaJIT)  
**Structure**:
- `init.lua` - Main configuration entry point
- `lsp/` - Language server configurations  
- `ftplugin/` - Filetype-specific settings
- `lua/` - Modular Lua configuration
- `plugin/` - Plugin configurations

**Key Features**:
- Minimal plugin approach (uses vim's built-in package manager)
- LSP configurations for multiple languages
- Kanagawa colorscheme
- Disabled built-in plugins for performance

### Spec-Driven Development Framework

**Location**: `.specify/` directory  
**Purpose**: AI-driven feature development workflow  

**Key Scripts**:
- `check-prerequisites.sh` - Validates project state for development
- `update-agent-context.sh` - Maintains AI agent context files  
- `setup-plan.sh` - Initializes feature planning
- `create-new-feature.sh` - Creates new feature specifications

**Workflow**: Features are developed using `specs/[###-feature-name]/` directories containing `plan.md`, `tasks.md`, etc.

## Validation and Testing

### No Formal Test Suite
This repository has **no traditional test suite** - it's a configuration repository. Validation is done through:

1. **Manual Verification**: 
   - Symlinks created correctly: `ls -la ~/ | grep -E "\.config|\.local"`
   - Neovim loads without errors: `nvim --headless +quit`
   - Scripts are executable: `find dot-local/bin -type f -exec test -x {} \; -print`

2. **Build Validation**:
   ```bash
   make init           # Should complete without errors
   make               # Requires stow - will fail in CI without it
   ```

3. **Script Validation**:
   ```bash
   # Test prerequisite checking
   ./.specify/scripts/bash/check-prerequisites.sh --help
   ```

### Common Build Issues

1. **Stow not installed**: Main `make` command fails with "command not found"
   - **Solution**: Install stow package for your distribution
   - **CI Note**: This will always fail in environments without stow

2. **Permission errors**: Scripts not executable
   - **Solution**: `chmod +x dot-local/bin/*` (handled by Makefile)

3. **Missing directories**: XDG directories don't exist  
   - **Solution**: Run `make init` first

## Development Workflow

### For Configuration Changes:
1. Edit files in repository (not in `~/`)
2. Run `make delete && make` to refresh symlinks
3. Test configuration manually

### For AI Agent Development:
1. Work in feature branches named appropriately
2. Use `.specify/scripts/bash/` for automation
3. Update agent context with exact command: `./.specify/scripts/bash/update-agent-context.sh copilot`
4. Follow spec-driven development patterns in `.specify/templates/`

### For Script Development:
1. Add scripts to `dot-local/bin/`
2. Make executable: `chmod +x dot-local/bin/script-name`
3. Use `#!/usr/bin/env bash` shebang
4. Test before committing

## Critical Notes for Agents

1. **TRUST THESE INSTRUCTIONS**: Only search/explore if information here is incomplete or incorrect

2. **Stow Dependency**: The main build command WILL FAIL without stow installed - this is expected in many CI environments

3. **Path Conventions**: 
   - Use absolute paths when working with repository files
   - Repository root: `/home/runner/work/dotfiles/dotfiles` (in CI)
   - Symlink targets: User's home directory

4. **Agent Context Updates**: When updating AI agent files, use the exact command:
   ```bash
   ./.specify/scripts/bash/update-agent-context.sh copilot
   ```
   Do not add or modify arguments.

5. **Containerized Workflow**: This setup is designed for Podman Toolbox containers on Fedora Silverblue - some functionality may not work on other platforms

6. **No Breaking Changes**: When modifying configurations, preserve existing functionality - these are personal dotfiles in active use
=======
# Dotfiles Repository - GitHub Copilot Instructions

## Repository Summary

This is a personal dotfiles repository designed for Fedora Silverblue (an immutable operating system) focused on creating a customized CLI toolbox environment centered around Neovim and associated CLI tooling. The repository uses GNU Stow for dotfile management and includes sophisticated spec-driven development workflows.

**Key Purpose**: Provide a reproducible, containerized development environment using Podman toolboxes with extensive Neovim configuration and CLI tools.

## High Level Repository Information

- **Repository Type**: Personal dotfiles with development toolchain
- **Size**: ~55 files total (8 shell scripts, 47 Lua files, multiple config files)
- **Primary Languages**: 
  - Bash (system scripts, toolbox management)  
  - Lua (Neovim configuration)
  - Makefile (build automation)
- **Target Runtime**: Fedora Silverblue with Podman toolboxes
- **Key Technologies**:
  - GNU Stow (dotfile management)
  - Podman/Toolbox (containerized development)
  - Neovim (editor with extensive Lua config)
  - GNOME dconf (desktop preferences)

## Build and Setup Commands

### Prerequisites

**Required tools** (must be installed on the host system):
- `podman` (container runtime)
- `toolbox` (container development environments) 
- `dconf` (GNOME configuration system)
- `stow` (symlink farm manager)
- `make` (build automation)

**Note**: On Fedora Silverblue, podman, toolbox, and dconf are pre-installed.

### Bootstrap/Setup Sequence

**ALWAYS run commands in this exact order:**

1. **Initialize directory structure** (creates required directories):
   ```bash
   make init
   ```
   - Creates `~/.local/bin`, `~/.cache/nvim`, `~/.local/state/nvim`
   - Creates Neovim data directories for language servers
   - Makes bin scripts executable
   - **Time**: < 5 seconds

2. **Install GNU Stow** (if not available):
   ```bash
   # On Fedora:
   sudo dnf install stow
   # On Ubuntu/Debian:  
   sudo apt install stow
   ```

3. **Deploy dotfiles** (default make target):
   ```bash
   make
   ```
   - Symlinks all dotfiles using GNU Stow with `--dotfiles` option
   - Makes all bin scripts executable
   - **Time**: 5-10 seconds
   - **Requirements**: Must have write access to home directory
   - **Warning**: Will overwrite existing dotfiles without backup

### Build Commands

| Command | Purpose | Time | Prerequisites |
|---------|---------|------|---------------|
| `make` | Default - deploy dotfiles via stow | 5-10s | stow installed |
| `make init` | Create directory structure | <5s | None |
| `make delete` | Remove symlinked dotfiles | 5-10s | stow installed |
| `make clean_nvim` | Remove all Neovim data/config | <5s | None |
| `make ai` | Install specify-cli tool | 30-60s | uv package manager |

### Testing and Validation

**Validate dotfile deployment**:
```bash
# Check if key files are properly linked
ls -la ~/.config/nvim/init.lua
ls -la ~/.local/bin/tbx-reset
```

**Test Neovim configuration** (if nvim is installed):
```bash
# Test headless startup
nvim --headless -c "lua print('Config loaded')" -c qall
# Check plugin installation
./~/.local/bin/nv_info
```

**Validate toolbox setup** (if podman/toolbox available):
```bash
# Test toolbox reset script  
./~/.local/bin/tbx-reset --dry-run
```

### Common Build Issues and Workarounds

1. **Stow conflicts with existing files**:
   - **Error**: "WARNING! stowing ... would cause conflicts"
   - **Solution**: Backup and remove conflicting files, or use `make delete` first

2. **Permission issues with bin scripts**:
   - **Error**: Scripts not executable  
   - **Solution**: Run `chmod +x dot-local/bin/*` manually

3. **Missing dependencies**:
   - **Podman not available**: Toolbox features won't work, but dotfiles will deploy
   - **Missing stow**: Install via package manager or skip stow-based deployment

## Project Layout and Architecture

### Root Directory Structure
```
/
├── .github/prompts/          # AI agent prompts (7 .md files)
├── .specify/                 # Spec-driven development system
│   ├── scripts/bash/         # Workflow automation scripts  
│   ├── templates/            # Document templates
│   └── memory/               # Project constitution
├── dot-bashrc.d/             # Bash configuration fragments
├── dot-config/               # XDG config directory contents
│   ├── nvim/                 # Neovim configuration (47 .lua files)
│   ├── gh/                   # GitHub CLI config
│   ├── git/                  # Git configuration  
│   ├── marksman/             # Markdown LSP config
│   └── opencode/             # OpenCode editor config
├── dot-local/bin/            # User executables (8 scripts)
├── Makefile                  # Build automation
└── README.md                 # Project documentation
```

### Key Configuration Files

| File | Purpose | Technology |
|------|---------|------------|
| `Makefile` | Build automation and setup | GNU Make |
| `.stow-local-ignore` | Files to exclude from stow | GNU Stow |
| `.luarc.json` | Lua language server config | Lua LSP |
| `.marksman.toml` | Markdown language server | Marksman LSP |
| `dot-config/nvim/init.lua` | Neovim entry point | Lua |
| `dot-local/bin/tbx-reset` | Toolbox container manager | Bash |

### The .specify Workflow System

This repository includes a sophisticated spec-driven development workflow located in `.specify/`:

**Key Scripts**:
- `update-agent-context.sh` - Updates AI agent context files  
- `check-prerequisites.sh` - Validates development environment
- `setup-plan.sh` - Creates feature planning structure
- `common.sh` - Shared functions and variables

**Expected Workflow**:
1. Feature branches named like: `001-feature-name`
2. Specs directory: `/specs/{branch-name}/`  
3. Documents: `spec.md`, `plan.md`, `tasks.md`, `research.md`
4. Agent context files updated automatically

**Note**: The workflow system expects feature branch naming conventions and may fail with standard GitHub branch names.

### Neovim Configuration Architecture

The Neovim setup is extensive with 47 Lua files organized as:

```
dot-config/nvim/
├── init.lua                  # Main entry point
├── lua/                      # Core Lua modules
│   ├── icons/                # Icon definitions  
│   ├── lightbulb/            # LSP lightbulb functionality
│   ├── scratch/              # Scratch buffer utilities
│   └── util/                 # Utility functions
├── ftplugin/                 # Filetype-specific configs
└── meta/                     # LuaJIT metadata for LSP
```

**Plugin Management**: Uses `vim.pack.add()` in `dot-local/bin/nvim_plugins`

### Utility Scripts in dot-local/bin

| Script | Purpose | Dependencies |
|--------|---------|--------------|
| `nv_info` | Display Neovim runtime info | nvim |
| `nv_log` | Show Neovim logs | nvim | 
| `nvim_lspconfig` | Download LSP configs | nvim, wget |
| `nvim_plugins` | Install Neovim plugins | nvim |
| `nvim_startuptime` | Profile Neovim startup | nvim |
| `nvim_treesitter` | Manage treesitter parsers | nvim |
| `tbx-reset` | Reset/recreate toolbox container | podman, toolbox, dconf |
| `trigger-workflow` | Trigger GitHub workflow | curl, github token |

## Validation Steps and Checks

### Pre-Deployment Validation
```bash
# Check required tools
which make stow
# Validate repository structure  
test -f Makefile && test -d dot-config && echo "Structure OK"
```

### Post-Deployment Validation  
```bash
# Confirm symlinks created
ls -la ~/.config/nvim/init.lua ~/.local/bin/tbx-reset
# Test key functionality
make init  # Should complete without errors
```

### Development Environment Validation
```bash
# If using .specify workflow system
./.specify/scripts/bash/check-prerequisites.sh --paths-only
# Check agent context update capability
./.specify/scripts/bash/update-agent-context.sh --help
```

## Dependencies and Special Requirements

### Hidden Dependencies
- **jq**: Required by `tbx-reset` script for JSON parsing
- **curl**: Required by `trigger-workflow` script 
- **wget**: Required by `nvim_lspconfig` for downloading configs
- **GitHub Personal Access Token**: Required for `trigger-workflow` in `~/Projects/.github-access-token`

### Fedora Silverblue Specific
- Uses `dconf` for GNOME desktop configuration
- Designed for immutable OS with layered packages in containers  
- Integrates with Ptyxis terminal via dconf settings
- Expects container-based development workflow

### Development Environment
- **Neovim**: Primary editor (extensive Lua configuration)
- **Language Servers**: Marksman (Markdown), bashls (Bash), harper_ls (writing)
- **Container Runtime**: Podman for toolbox environments
- **Font**: BlexMono for terminal (configured via dconf)

## Trust These Instructions

These instructions are comprehensive and tested. Only perform additional searches if:
1. You encounter specific errors not covered above
2. The repository structure has changed significantly  
3. New dependencies or requirements are introduced
4. The .specify workflow system behavior differs from documented

The build commands, file locations, and architectural descriptions are accurate as of the last update and should be trusted for efficient development.
