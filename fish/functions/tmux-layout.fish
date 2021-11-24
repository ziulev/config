function tmux-layout
    tmux new-window -n "insicrcles"
    tmux send-keys "cd ~/Developer/territory/incircles-frontend && nvim" C-m
    tmux split-window -h
    tmux resize-pane -R 20
    tmux send-keys "cd ~/Developer/territory/incircles-frontend && clear" C-m
end

