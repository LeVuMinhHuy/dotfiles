function fish_prompt
    set -l last_status $status
    set -l cwd (prompt_pwd)
    set -l time '['(date +%H:%M)']'

    if not test $last_status -eq 0
        set_color --bold white -b red
        echo -n ' ! '
        set_color normal
    end

    # Display time
    set_color black -b "#FFE3A9"
    echo -n $time

    # Display current path
    set_color black -b white 
    echo -n " $cwd "

    # Show git branch and dirty state
    set -l git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    set -l git_dirty (command git status -s --ignore-submodules=dirty 2> /dev/null)
    if test -n "$git_branch"
        if test -n "$git_dirty"
            set_color black -b yellow
            echo -n " $git_branch "
        else
            set_color black -b green
            echo -n " $git_branch "
        end
    end

    # Add a space
    set_color normal
    echo -n ' = '
end
