function proxy
    set -f prefixes HTTPS HTTP ALL FTP
    set -f ignore localhost,127.0.0.0/0,nwie.net,192.168.0.0/16,10.0.0.0/8

    switch $argv[1]
    case squid home on
        set -f target http://127.0.0.1:3128
    case off
        for prefix in $prefixes
            set -e {$prefix}_PROXY
        end
        set -e NO_PROXY
        return
    case status
        for prefix in $prefixes
            echo \t{$prefix}_PROXY:\t(eval echo \${$prefix}_PROXY)
        end
        return
    case '*'
        set -f target $argv[1]
    end

    for prefix in $prefixes
        set -gx {$prefix}_PROXY $target
    end
    set -gx NO_PROXY $ignore
end
