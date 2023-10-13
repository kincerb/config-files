set -gx EDITOR nvim
set -gx VISUAL $EDITOR

set -gx PAGER bat -p
set -gx BAT_THEME gruvbox-dark
set -gx SYSYEMD_PAGER bat --plain --language syslog
set -gx SYSTEMD_PAGERSECURE true
set -gx GOPATH ~/.local/go
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT "-c"
set -gx ATUIN_NOBIND "true"
set -gx LESS "-FiXR"

set -l _fzf_opts "--color=dark"
set -a _fzf_opts "--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe"
set -a _fzf_opts "--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef"

set -gx FZF_DEFAULT_COMMAND "rg --ignore-case --files"
set -gx FZF_CTRL_T_OPTS "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --select-1 --exit-0"
set -gx FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"
set -gx FZF_DEFAULT_OPTS $_fzf_opts
