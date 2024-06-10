set -gx EDITOR nvim
set -gx VISUAL $EDITOR

set -gx GOPATH ~/.local/go

set -gx PAGER "bat --plain"
set -gx BAT_THEME gruvbox-dark
set -gx SYSTEMD_PAGER bat --plain
set -gx SYSTEMD_PAGERSECURE true
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c
set -gx ATUIN_NOBIND true
