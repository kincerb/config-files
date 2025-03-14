set --global --export GOPATH $HOME/.local/go

set homebrew /home/linuxbrew/.linuxbrew
set custom_paths $homebrew/bin $HOME/.local/bin $GOPATH/bin $HOME/.cargo/bin
set man_paths $homebrew/share/man /usr/share/man /usr/local/share/man /usr/local/man

if not set -q VIRTUAL_ENV
    for _path in $custom_paths
        fish_add_path --append --move --path --global $_path
    end
end

for _path in $man_paths
    if path is --type=dir $_path
        if not contains $_path $MANPATH
            set --global --export --append MANPATH $_path
        end
    end
end
