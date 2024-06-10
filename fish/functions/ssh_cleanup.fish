function ssh_cleanup
    for socket in ~/.ssh/socket/*
        ssh -O exit -S $socket x &>/dev/null
    end
end
