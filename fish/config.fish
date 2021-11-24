if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias c='clear'

alias ns='npm run start'
alias ni='npm install'

alias ys='yarn start'
alias yi='yarn'

alias vim='nvim'

# Autostart tmux
if status is-interactive
and not set -q TMUX
    # exec tmux
    # exec tmux new-session \; split-window -h \; new-window -n 'incircles'
end

