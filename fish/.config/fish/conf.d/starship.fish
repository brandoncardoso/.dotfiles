set -g __starship_first_prompt 1

function __starship_newline --on-event fish_prompt
    if test "$__starship_first_prompt" = 1
        set __starship_first_prompt 0
    else
        echo
    end
end

if command -q starship
    starship init fish | source
end
