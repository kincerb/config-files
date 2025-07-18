function proxy
    set -f prefixes HTTPS HTTP ALL FTP
    set -f ignore localhost,127.0.0.0/0,nwie.net,192.168.0.0/16,10.0.0.0/8

    switch $argv[1]
        case squid home on
            set -f target http://127.0.0.1:3128
        case off
            for prefix in $prefixes
                set -e (string join '_' {$prefix} PROXY)
                set -e (string join '_' (string lower {$prefix}) proxy)
            end
            set -e NO_PROXY
            set -e no_proxy
            return 0
        case status
            for prefix in $prefixes
                echo \t{$prefix}_PROXY:\t(eval echo \${$prefix}_PROXY)
                echo \t(string join '_' (string lower {$prefix}) proxy):\t(eval echo \$(string join '_' (string lower {$prefix}) proxy))
            end
            return 0
        case '*'
            set -f target $argv[1]
    end

    for prefix in $prefixes
        set -gx (string join '_' {$prefix} PROXY) $target
        set -gx (string join '_' (string lower {$prefix}) proxy) $target
    end
    set -gx NO_PROXY $ignore
    set -gx no_proxy $ignore
end
