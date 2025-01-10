set --global --export GOPATH $HOME/.local/go

set custom_paths $HOME/.local/bin $GOPATH/bin $HOME/.cargo/bin
set man_paths /usr/share/man /usr/local/share/man /usr/local/man

if not set -q VIRTUAL_ENV
    for _path in $custom_paths
        fish_add_path --append --global $_path
    end
end

for _path in $man_paths
    if path is --type=dir $_path
        if not contains $_path $MANPATH
            set --global --export --append MANPATH $_path
        end
    end
end

if test \( -e /home/linuxbrew/.linuxbrew/bin/brew \)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    set --local brew_comp "$HOMEBREW_PREFIX"/share/fish/vendor_completions.d
    if not contains $brew_comp $fish_complete_path
        set --global --export --prepend fish_complete_path $brew_comp
    end
end
