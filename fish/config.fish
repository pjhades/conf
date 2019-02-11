set -xg PATH ~/.cargo/bin $PATH

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # Just calculate this once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __git_cb
        set __git_cb "["(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)"]"
    end

    set -l color_cwd
    set -l suffix
    switch $USER
    case root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    case '*'
        set color_cwd $fish_color_cwd
        if [ $last_status -eq 1 ]
            set suffix (set_color red)'❯❯❯'
        else
            set suffix (set_color FFF8D2)'❯'(set_color yellow)'❯'(set_color green)'❯'
        end
    end

    echo -n -s (set_color yellow)(date '+%H:%M:%S')(set_color normal) \
               ' ' \
               (set_color 1EF)"$USER"(set_color normal) ' ' \
               (set_color $color_cwd) (prompt_pwd) (set_color normal) ' ' \
               $__git_cb ' ' \
               "$suffix "
end
