local M = {}

--[[
A project is defined as a git contolled repo
A keybind will
 - open a *project* in a ptyxis tab in the default toolbox container.
 - run the nv




--
When we need a full screen and don't want a popup window.
 each tab has one window
 named tabs list
 1. tabMain: main tab: code editing tab  has 3 windows:
   - main code editing widow: lhs or full screen
   - Alt window: rhs or full screen display the alternate file for the main code editing window eg: test file for the main module file
   - show window: pinned bottom full width to display data or run commands in named buffers
2. tabAlt: the alt tab has one window and 3 terminal buffers:
  1. bufBashToolbox: terminal buffer bash prompt in toolbox
  2. bufPiAgent:     terminal buffer - runs the pi-agent in toolbox
  3. tab host-spawn: terminal buffer  - runs host-spawn for running commands outside of the toolbox:

on opening a project --

--]]


M.version = "0.1.0"
M.description = [[

 - overview: module overview which describes the module's purpose and functionality
 - scope: module scope
 - usage: how to use the module
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] todo task 1
 - [ ] todo task 3
]]

M.references = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

return M
