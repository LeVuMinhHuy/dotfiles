function fish_title
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd);
end


function title
    set -l title $argv[1]
    function fish_title --inherit-variable title
        echo "$title"
    end
end
