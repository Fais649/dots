#!/bin/zsh
SESSION_NAME="ghostty"

zsh -c tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
 # If the session exists, reattach to it
 zsh -c tmux attach-session -t $SESSION_NAME
else
 # If the session doesn't exist, start a new one
 zsh -c tmux new-session -s $SESSION_NAME -d
 zsh -c tmux attach-session -t $SESSION_NAME
fi
