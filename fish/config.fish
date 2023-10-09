set fish_greeting
set custom_paths ~/.local/bin ~/.local/fzf/bin $GOPATH/bin

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

for _path in $custom_paths
    fish_add_path -a $_path
end

if test -z "$SSH_CONNECTION"
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end


if not pgrep -U $USER gpg-agent &>/dev/null
    gpg-agent --daemon
end

if status is-interactive
    /usr/bin/starship init fish --print-full-init | source
    atuin init fish | source
    bind \cr _atuin_search
end

alias ls='exa --all --long --group --color=always --group-directories-first --icons' # preferred listing
alias lt='exa --all --tree --color=always --group-directories-first --icons' # tree listing
