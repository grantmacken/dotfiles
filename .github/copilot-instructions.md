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