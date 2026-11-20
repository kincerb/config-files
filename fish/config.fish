if test -e /usr/share/garuda/garuda-fish-config/config.fish
    source /usr/share/garuda/garuda-fish-config/config.fish
end

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
