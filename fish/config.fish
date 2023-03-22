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

# pnpm
set -gx PNPM_HOME "/home/mhhmm/.local/share/pnpm"

# rustlang
set -gx RUST_HOME "/home/mhhmm/.cargo/bin"

set -gx PATH "$PNPM_HOME" $PATH
set -gx PATH "$RUST_HOME" $PATH
