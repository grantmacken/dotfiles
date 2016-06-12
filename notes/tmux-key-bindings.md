#TMUX NOTES

##Controlling TMUX Panes and Vim splits

(tmux pain control)[https://github.com/tmux-plugins/tmux-pain-control]
automatically creates the following bindings

##Navigation Between Panes
  select panes using prefix with vim like bindings
  This also navigates between tmux and vim panes.
  ctrl + h or k j or k or l

##Resizing Panes
  resize panes using prefix with vim like bindings
  ctrl + H + J or L or K or L

Everything else should be prefixed
Prefix = CTRL + Space

##Split Panes

-  ```prefix + -``` Horizontal split
-  ```prefix + |``` Vertical  split
-  ```prefix + x``` Kill the current pane ( interactive )

##Toggle Zooming Focus Pane

- ```prefix + z``` z will maximize current pane
to bring other panes into focus hit ```prefix z``` again.
You know whether you are in Zoom by checking the status bar for the Z

## Window Creation and Destruction

-  ```prefix + c``` create Window
-  ```prefix + &``` Kill window ( interactive )
-  ```prefix + i``` information about window
-  ```prefix + f``` find window.
-  ```prefix + ,``` rename window. Note: save workspace ```prefix + Ctrl s```
-  ```prefix + p or n``` previous or next window
-  ```prefix + q``` show panes

http://unix.stackexchange.com/questions/24274/attach-to-different-windows-in-session
##Session Creation

Sessions are cheap. Make a new session for each project.

- ```prefix + g``` - prompts for session name and switches to it.
  Performs 'kind-of' name completion.<br/>
  Faster than the built-in `prefix + s` prompt for long session lists.
- ```prefix + C``` (shift + c) - prompt for creating a new session by name.
- ```prefix + X``` (shift + x) - kill current session without detaching tmux.
- ```prefix + S``` (shift + s) - switches to the last session.
  The same as built-in `prefix + L` that everyone seems to override with
  some other binding.
- ```prefix + @``` - promote current pane into a new session.<br/>
          Analogous to how `prefix + !` breaks current pane to a new window.
- `:move-window -r`  to renumber and reorder windows

##Workspace Saving and Restoring

 save before exit - restore on load

- ```prefix + Ctrl-s``` - save workspce
- ```prefix + Ctrl-r``` - restore workspace

