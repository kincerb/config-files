set fish_greeting
set custom_paths ~/.local/bin ~/.local/fzf/bin $GOPATH/bin
set man_paths /usr/share/man /usr/local/share/man /usr/local/man ~/.local/pipx/venvs/ranger-fm/share/man ~/.local/fzf/man

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 5000
set -U __done_notification_urgency_level normal

for _path in $man_paths
    if path is --type=dir $_path
        if not contains $_path $MANPATH
            set -gax MANPATH $_path
        end
    end
end

for _path in $custom_paths
    fish_add_path -a $_path
end

if test -z "$SSH_CONNECTION"
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

if status is-interactive
    /usr/bin/starship init fish --print-full-init | source
    atuin init fish | source
    bind \cr _atuin_search
end

function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

alias ls='exa --all --long --group --color=always --group-directories-first --icons' # preferred listing
alias lt='exa --all --tree --color=always --group-directories-first --icons' # tree listing
