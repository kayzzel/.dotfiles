#!/bin/bash

PROJECT_DIR="$HOME/Documents/School42/common_core/python_modules/01"

# ----------------------------
# Utilities session
# ----------------------------
tmux new-session -d -s utilities -n main "w3m https://lite.duckduckgo.com"

# ----------------------------
# General session
# ----------------------------
tmux new-session -d -s general -n main # first window

# Monitoring window with panes
tmux new-window -t general -n monitoring "htop"  # left pane

# Horizontal split: cbonsai (right pane)
# Horizontal split: right pane 60% of the width
tmux split-window -h -p 60 -t general:monitoring "cbonsai -li"

# Vertical split of right pane: pipes
tmux split-window -v -p 30 -t general:monitoring.2 "pipes.sh"

# ----------------------------
# Work session
# ----------------------------
tmux new-session -d -s work -n main -c "$PROJECT_DIR"

# Editor window
tmux new-window -t work -n editor -c "$PROJECT_DIR" "nvim"

# ----------------------------
# Attach to general session
# ----------------------------
tmux attach -t general
