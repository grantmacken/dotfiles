#!/bin/bash

#xrandr --output DVI-0 --mode 1920x1080 --rate 60
#xrandr --output VGA-0 --mode 1920x1080 --rate 60

#xrandr --output DVI-0 --right-of VGA-0
#xrandr --output VGA-0 --left-of DVI-0
:
#xrandr --output VGA-0 --primary

#https://patrickmn.com/blog/lowering-gaming-mouse-sensitivity-in-ubuntu-9-10/:
# xinput --list-props "Cooler Master Storm Alcor Mouse"

xinput --set-prop "Cooler Master Storm Alcor Mouse" "Device Accel Constant Deceleration" 5
xinput --set-prop "Cooler Master Storm Alcor Mouse" "Device Accel Velocity Scaling" 1

cd "${PROJECTS}"
#gnome-terminal -e "tmux -u -2 new -s '${BASE_SESSION}'"
gnome-terminal ---geometry 173x47+1920+24 -e "tmux -u -2 new -s '${BASE_SESSION}'"

#http://unix.stackexchange.com/questions/81335/xubuntu-mouse-sensitivity-way-too-high
## xset q | grep -A 1 Pointer
## xset m ACCELERATION THRESHOLD
# xset m 1/2 4


#http://unix.stackexchange.com/questions/81335/xubuntu-mouse-sensitivity-way-too-high
## xset q | grep -A 1 Pointer
## xset m ACCELERATION THRESHOLD
# xset m 1/2 4


#http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-k:ey-useful/

#sudo gedit  /etc/default/keyboard
# XKBOPTIONS="caps:ctrl_modifier"
# sudo dpkg-reconfigure -phigh console-setup


#setxkbmap -layout us -option ctrl:nocaps
#xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
