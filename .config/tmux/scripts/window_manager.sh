if [ $1 = "G" ]; then
 tmux split-window -vc "#{pane_current_path}"
 tmux split-window -hc "#{pane_current_path}"
fi
