set --local nvim_loc (which nvim)
set --local bat_loc (which bat)
set --local atuin_loc (which atuin)
set --local eza_loc (which eza)

set --global --export LESS -FIXR

if test -n "$nvim_loc"
    set --global --export EDITOR $nvim_loc
    set --global --export VISUAL $nvim_loc
end

if test -n "$bat_loc"
    set --global --export PAGER "$bat_loc --plain"
    set --global --export BAT_THEME gruvbox-dark
    set --global --export SYSTEMD_PAGER "$bat_loc --plain"
    set --global --export SYSTEMD_PAGERSECURE true
    set --global --export MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set --global --export MANROFFOPT -c
end

if test -n "$atuin_loc"
    if status is-interactive
        set --global --export ATUIN_NOBIND true
        starship init fish --print-full-init | source
        atuin init fish | source
        bind \cr _atuin_search
    end
end

if test -n "$eza_loc"
    alias ls='eza --all --long --group --color=always --group-directories-first --icons' # preferred listing
    alias lt='eza --all --tree --color=always --group-directories-first --icons' # tree listing
end
