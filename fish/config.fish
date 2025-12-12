set fish_greeting

set --global --export GPG_TTY (tty)

set GPG_SSH_SOCK (gpgconf --list-dirs agent-ssh-socket)

if not set -q SSH_AUTH_SOCK
    set --global --export SSH_AUTH_SOCK "$GPG_SSH_SOCK"
end

function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

if test -e "$HOME"/.config/fish/secrets.fish
    source "$HOME"/.config/fish/secrets.fish
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 5000
set -U __done_notification_urgency_level normal
set -U --append __done_exclude '^nvim'
set -U --append __done_exclude '^y'
set -U --append __done_exclude '^yazi'
