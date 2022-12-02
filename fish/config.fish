if type -q exa
  alias ll "exa -l -g"
  alias lla "ll -a"
  alias lll "exa -l -g --tree --level=2"
  alias llla "exa -l -g --tree --level=2 -a"
end

if status --is-interactive
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty
  end
end

if status is-interactive
and not set -q TMUX
  exec tmux
end

alias vim "nvim"
alias testwm "Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome"
alias barney "vim /home/mhhmm/.config/awesome/rc.lua"
alias rust_me_daddy 'cd /home/mhhmm/Documents/somewhereineurope/rust && vim'
alias fish_me_daddy 'cd /home/mhhmm/.config/fish && vim'
alias nextgen 'cd /home/mhhmm/Documents/sourcecodedotcomdotau/NEXTGEN'
alias bash_me_daddy 'cd /home/mhhmm/Documents/somewhereineurope/bash'
alias r 'ranger'
alias torrent "transmission-cli"

# pnpm
set -gx PNPM_HOME "/home/mhhmm/.local/share/pnpm"

# rustlang
set -gx RUST_HOME "/home/mhhmm/.cargo/bin"

# solana
set -gx SOLANA_HOME "/home/mhhmm/.local/share/solana/install/active_release/bin:$PATH"

set -gx PATH "$PNPM_HOME" $PATH
set -gx PATH "$RUST_HOME" $PATH
set -gx PATH "$SOLANA_HOME" $PATH
