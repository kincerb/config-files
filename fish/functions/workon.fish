function workon
    set -f env_name $argv[1]
    source $env_name/bin/activate.fish
end
