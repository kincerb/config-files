umask 0027

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GOPATH="${HOME}/.local/go"

if [[ "${OSTYPE}" =~ ^darwin ]]; then
    export PLATFORM_BASHRC="${HOME}/.config/bash.d/darwin.sh"
else
    export PLATFORM_BASHRC="${HOME}/.config/bash.d/linux.sh"
fi

for _path in "${HOME}/.local/bin" /usr/local/go/bin "${GOPATH}/bin" "${HOME}/.fzf/bin"; do
    if [ -d "${_path}" ]; then
        if ! [[ "${PATH}" =~ :?"${_path}":? ]]; then
            export PATH=$_path:$PATH
        fi
    fi
done
unset _path

if [ -d "${HOME}/.local/pipx/venvs/ranger-fm/share/man" ]; then
    export MANPATH=":${HOME}/.local/pipx/venvs/ranger-fm/share/man"
fi

# use screen-256color for tmux sessions
if (compgen -v KITTY &>/dev/null); then
    export TERM=xterm-kitty
elif [ -z "${TMUX}" ]; then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi

if [ -e /usr/share/defaults/etc/profile ]; then
    source /usr/share/defaults/etc/profile
fi

# Bash shell options
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob
shopt -s extglob
shopt -s checkwinsize

# Environment variables
if ! (which bat &>/dev/null); then
    export PAGER=less
else
    export PAGER="bat -p"
    alias cat="bat -p"
    export BAT_THEME="gruvbox-dark"
    export MANPAGER="sh -c 'col -bx |bat -l man -p'"
    export MANROFFOPT="-c"
fi
export PROMPT_DIRTRIM=2
export SEND_256_COLORS_TO_REMOTE=1
export LESS="-FiXR"
export HISTCONTROL='erasedups:ignorespace'
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE='history*'
export HISTTIMEFORMAT='%F %T '

if (which fzf &>/dev/null); then
    export FZF_DEFAULT_COMMAND='rg --ignore-case --files'
    export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --select-1 --exit-0"
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
fi
# Source in all shared configs
for x in ~/.config/bash.d/{colors,secrets,aliases,functions}.sh; do
  if [ -e "${x}" ]; then
    source "${x}"
  fi
done
unset x

# Source host specific stuff
if [ -e "${PLATFORM_BASHRC}" ]; then
  source "${PLATFORM_BASHRC}"
fi

if [ -z "${SSH_CONNECTION}" ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi


# If this is a subshell under a virtual env, source it again
# TODO: Fix the path nightmare that this causes
if [ ! -z "${VIRTUAL_ENV}" ]; then
    source "${VIRTUAL_ENV}"/bin/activate
fi

if ! (compgen -v STARSHIP &>/dev/null); then
    export PS1="${__NEON_YELLOW}${HOSTNAME%%.*} ${__ORANGE}\W${__DARK_GREY}\$(git_branch)${__BLUE_GREEN} \$ ${__RESET}"
    export PS2="\[\033[0;36m\] --\[\033[0m\]> "
    export PS3='> '
    export PS4='+ '
    export PROMPT_COMMAND="set_window_title"
else
    export starship_precmd_user_func="set_window_title"
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
