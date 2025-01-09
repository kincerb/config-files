set fish_greeting

if test \( -z "$SSH_CONNECTION" \) -o \( "$TERM_PROGRAM" = WezTerm \)
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    if test ! -S "$SSH_AUTH_SOCK"
        gpg-connect-agent /bye &>/dev/null
    end
end

function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 5000
set -U __done_notification_urgency_level normal
