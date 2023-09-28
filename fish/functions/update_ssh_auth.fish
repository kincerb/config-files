function update_ssh_auth
    set -gx SSH_AUTH_SOCK (tmux showenv SSH_AUTH_SOCK |string split --fields 2 '=')
end
