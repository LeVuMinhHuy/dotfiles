#if type -q exa
#  alias ll "exa -l -g"
#  alias lla "ll -a"
#  alias lll "exa -l -g --tree --level=2"
#  alias llla "exa -l -g --tree --level=2 -a"
#end

if type -q lsd
  alias ls 'lsd -l'
  alias ll "lsd -l"
  alias lld "lsd -l --total-size"
  alias lla "lsd -la"
  alias llad "lsd -la --total-size"
  alias lll "lsd -l --tree --depth=2"
  alias llld "lsd -l --tree --depth=2 --total-size"
  alias llla "lsd -l --tree --depth=2 -a"
  alias lllad "lsd -l --tree --depth=2 -a --total-size"
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
alias crabpls 'cd /home/mhhmm/Documents/somewhereineurope/rust'
alias nextgen 'cd /home/mhhmm/Documents/sourcecodedotcomdotau/NEXTGEN'
alias r 'ranger'
alias torrent "transmission-cli"
alias sw 'tmux switch-client -t '
alias myconfig 'cd /home/mhhmm/Documents/somewhereineurope/myconfig/dotfiles'
alias home 'cd /home/mhhmm/Documents/somewhereineurope'
alias oss 'cd /home/mhhmm/Documents/somewhereineurope/oss'

# pnpm
set -gx PNPM_HOME "/home/mhhmm/.local/share/pnpm"

# rustlang
set -gx RUST_HOME "/home/mhhmm/.cargo/bin"

set -ga fish_user_paths $RUST_HOME $PNPM_HOME

# asdf
source /opt/asdf-vm/asdf.fish
