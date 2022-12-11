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
alias sw 'tmux switch-client -t '

# For work only
set -gx PAT "nqy5243qcd7huee6hsoflxlheo2vgjrtfsxwn2oxjzokjjss3ksq"
set -gx B64_PAT "Om5xeTUyNDNxY2Q3aHVlZTZoc29mbHhsaGVvMnZnanJ0ZnN4d24yb3hqem9rampzczNrc3E="
alias pull_deploy_uat 'git -c http.extraHeader="Authorization: Basic $B64_PAT" pull origin uat'
alias pull_deploy_dev 'git -c http.extraHeader="Authorization: Basic $B64_PAT" pull origin develop'
alias push_deploy_uat 'git -c http.extraHeader="Authorization: Basic $B64_PAT" push origin uat'
alias push_deploy_dev 'git -c http.extraHeader="Authorization: Basic $B64_PAT" push origin develop'
alias pull_deploy_prod 'git -c http.extraHeader="Authorization: Basic $B64_PAT" pull origin prod'
alias push_deploy_prod 'git -c http.extraHeader="Authorization: Basic $B64_PAT" push origin prod'
alias git_deploy 'git -c http.extraHeader="Authorization: Basic $B64_PAT"'

# For europe only
alias fund_project 'cd /home/mhhmm/Documents/somewhereineurope/fund'

# pnpm
set -gx PNPM_HOME "/home/mhhmm/.local/share/pnpm"

# rustlang
set -gx RUST_HOME "/home/mhhmm/.cargo/bin"

# solana
set -gx SOLANA_HOME "/home/mhhmm/.local/share/solana/install/active_release/bin:$PATH"

set -gx PATH "$PNPM_HOME" $PATH
set -gx PATH "$RUST_HOME" $PATH
set -gx PATH "$SOLANA_HOME" $PATH
