#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-04-05 17:37
#===============================================================================

# $1: option
# $2: default value
tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
tmux_set() {
    tmux set-option -gq "$1" "$2"
}

# Options
upload_speed_icon=$(tmux_get '@tmux_power_upload_speed_icon' '')
download_speed_icon=$(tmux_get '@tmux_power_download_speed_icon' '')
session_icon="$(tmux_get '@tmux_power_session_icon' '')"
user_icon="$(tmux_get '@tmux_power_user_icon' '')"
# user_icon="$(tmux_get '@tmux_power_user_icon' '👥')"
time_icon="$(tmux_get '@tmux_power_time_icon' '')"
date_icon="$(tmux_get '@tmux_power_date_icon' '')"
# date_icon="$(tmux_get '@tmux_power_date_icon' '亂')"
show_upload_speed="$(tmux_get @tmux_power_show_upload_speed false)"
show_download_speed="$(tmux_get @tmux_power_show_download_speed false)"
prefix_highlight_pos=$(tmux_get @tmux_power_prefix_highlight_pos)
# short for Theme-Colour
TC=$(tmux_get '@tmux_power_theme' 'gold')
case $TC in
    'gold' )
        TC='#ffb86c'
        ;;
    'redwine' )
        TC='#b34a47'
        ;;
    'moon' )
        TC='#00abab'
        ;;
    'forest' )
        TC='#228b22'
        ;;
    'violet' )
        TC='#9370db'
        ;;
    'snow' )
        TC='#fffafa'
        ;;
    'coral' )
        TC='#ff7f50'
        ;;
    'sky' )
        TC='#87ceeb'
        ;;
esac

G01=#080808 #232
G02=#121212 #233
G03=#1c1c1c #234
G04=#262626 #235
G05=#303030 #236
G06=#3a3a3a #237
G07=#444444 #238
G08=#4e4e4e #239
G09=#585858 #240
G10=#626262 #241
G11=#6c6c6c #242
G12=#767676 #243

FG="$G10"
BG="$G04"

# Status options
tmux_set status-interval 1
tmux_set status on

# Basic status bar colors
tmux_set status-fg "$FG"
tmux_set status-bg "$BG"
tmux_set status-attr none

# tmux-prefix-highlight
tmux_set @prefix_highlight_fg "$BG"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$BG,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$BG]#[bg=$TC]#[fg=$BG]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$BG]"

#     
# Left side of status bar
tmux_set status-left-bg "$G04"
tmux_set status-left-fg "G12"
tmux_set status-left-length 150
user=$(whoami)
LS="#[fg=$G04,bg=$TC,bold] $user_icon $user@#h #[fg=$TC,bg=$G06,nobold]#[fg=$TC,bg=$G06] $session_icon #S "
if "$show_upload_speed"; then
    LS="$LS#[fg=$G06,bg=$G05]#[fg=$TC,bg=$G05] $upload_speed_icon#{upload_speed} #[fg=$G05,bg=$BG]"
else
    LS="$LS#[fg=$G06,bg=$BG]"
fi
if [[ $prefix_highlight_pos == 'L' || $prefix_highlight_pos == 'LR' ]]; then
    LS="$LS#{prefix_highlight}"
fi
tmux_set status-left "$LS"

# Right side of status bar
tmux_set status-right-bg "$G04"
tmux_set status-right-fg "G12"
tmux_set status-right-length 150
# RS="#[fg=$TC,bg=$G06] $time_icon %T #[fg=$TC,bg=$G06]#[fg=$G04,bg=$TC] $date_icon %F "
RS="#[fg=$TC,bg=$G06] $time_icon %H:%M #[fg=$TC,bg=$G06]#[fg=$G04,bg=$TC] $date_icon %a %b%d"
if "$show_download_speed"; then
    RS="#[fg=$G05,bg=$BG]#[fg=$TC,bg=$G05] $download_speed_icon#{download_speed} #[fg=$G06,bg=$G05]$RS"
else
    RS="#[fg=$G06,bg=$BG]$RS"
fi
if [[ $prefix_highlight_pos == 'R' || $prefix_highlight_pos == 'LR' ]]; then
    RS="#{prefix_highlight}$RS"
fi
tmux_set status-right "$RS"

# Window status
tmux_set window-status-format " #I:#W#F "
tmux_set window-status-current-format "#[fg=$BG,bg=$G06]#[fg=$TC,bold] #I:#W#F #[fg=$G06,bg=$BG,nobold]"

# Window separator
tmux_set window-status-separator ""

# Window status alignment
# tmux_set status-justify centre
tmux_set status-justify left

# Current window status
tmux_set window-status-current-statys "fg=$TC,bg=$BG"



# Update by rodhash for my theming
# Pane border
# tmux_set pane-border-style "fg=$G07,bg=default"
#
# Active pane border
# tmux_set pane-active-border-style "fg=$TC,bg=$BG"
#
#
# Making lines transparent (black) on KDE Konsole
set -g pane-border-style "fg=blue,bg=black"
set -g pane-active-border-style "bg=black,fg=blue"




# Pane number indicator
tmux_set display-panes-colour "$G07"
tmux_set display-panes-active-colour "$TC"

# Clock mode
tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

# Message
tmux_set message-style "fg=$TC,bg=$BG"

# Command message
tmux_set message-command-style "fg=$TC,bg=$BG"

# Copy mode highlight
tmux_set mode-style "bg=$TC,fg=$FG"
