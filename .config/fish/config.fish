set -g fish_greeting

if status is-interactive
    starship init fish | source
end

# List Directory
alias ls="lsd"
alias l="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
alias ssh='kitten ssh'
