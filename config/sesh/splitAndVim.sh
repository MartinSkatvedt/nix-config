#!/usr/bin/env bash
tmux split-window -h
tmux select-pane -t :.+
tmux send-keys "nvim ." Enter
