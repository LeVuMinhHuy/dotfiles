if status is-interactive
    # Commands to run in interactive sessions can go here
end

if type -q exa
  alias ll "exa -l -g"
  alias lla "ll -a"
  alias lll "exa -l -g --tree --level=2"
  alias llla "exa -l -g --tree --level=2 -a"
end
