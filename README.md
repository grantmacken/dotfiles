# My dotfiles

This repository contains my personal dotfiles and configuration files for various tools and applications.
My atomic os is fedora silverblue. 

## Stow

## Per Project Workflow

A project is defined as a Git-controlled repository located in my `~/Projects` directory. 

I manage my project workspaces using a script named `ptyxis-keybinds`, which assigns keyboard shortcuts to specific projects (e.g., `<Control><Alt>1`, `<Control><Alt>2`). 

When a project keybind is triggered, the following environment is initialized:
- A new Ptyxis terminal tab opens.
- The tab is bound to a profile that uses my Toolbox as the default container.
- The working directory is set to the project root.
- A Neovim instance is launched automatically.

### Persistent Neovim Sessions

Neovim is configured to use a server-client architecture via Unix sockets. Each project gets its own isolated Neovim server. This ensures that closing the terminal does not kill your editing session.

| Action | User Shortcut | Ptyxis Behavior | Neovim Behavior |
| :--- | :--- | :--- | :--- |
| **Open Project (Initial)** | `<Control><Alt>1` | Opens a new project tab. | Starts a new Neovim server listening on a Unix socket. |
| **Close Tab** | `<Control><Shift>W` | Closes the current tab. | Server remains running in the background. |
| **Reopen Project** | `<Control><Alt>1` | Opens a new project tab. | Client attaches to the existing background Neovim server. |
| **Quit Ptyxis** | `<Control><Shift>Q` | Closes the entire terminal app. | Server remains running in the background. |
| **Restore Session** | `<Control><Alt>1` | Opens a new project tab. | Client attaches to the existing background Neovim server. |

### Terminal Tab Navigation

Ptyxis supports the following keyboard shortcuts for tab navigation:
| Action              | Shortcut         | Note                                      |
|---------------------|------------------|-------------------------------------------|
| Next Tab            | `Ctrl+PageDown`    | Cycles forward through the tabs.
| Previous Tab        | `Ctrl+PageUp`      | Cycles backward through the tabs.
| Direct Tab Access   | `Alt+1` ... `Alt+9`  | Directly jumps corresponding tab number 



