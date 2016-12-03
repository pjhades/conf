function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    # Just calculate this once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
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
            set suffix '❯'(set_color cyan)'❯'(set_color blue)'❯'
        end
    end

    echo -n -s (set_color yellow)"$USER"(set_color normal) \
               ' ' @ ' ' \
               (set_color cyan)"$__fish_prompt_hostname"(set_color normal) ' ' \
               (set_color $color_cwd) (prompt_pwd) (set_color normal) ' ' \
               "$suffix "
end
