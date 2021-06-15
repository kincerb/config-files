# ${HOME}/.bashrc
umask 027

if [ "${TILIX_ID}" ] || [ "${VTE_VERSION}" ]; then
    source /etc/profile.d/vte.sh
fi

if [[ "${OSTYPE}" =~ ^linux ]]; then
    export PLATFORM_BASHRC="${HOME}/.config/bash.d/linux.sh"
elif [[ "${OSTYPE}" =~ ^darwin ]]; then
    export PLATFORM_BASHRC="${HOME}/.config/bash.d/darwin.sh"
fi

LOCAL_BIN="${HOME}/.local/bin"

if ! [[ "${PATH}" =~ "${HOME}/.local/bin"  ]]; then
    export PATH=$PATH:$HOME/.local/bin
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# use screen-256color for tmux sessions
if [ -z "${TMUX}" ]; then
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
export PAGER=bat
export EDITOR=/usr/bin/vim
export GPG_TTY=$(tty)
export VISUAL=/usr/bin/vim
export PROMPT_DIRTRIM=2
export SEND_256_COLORS_TO_REMOTE=1
export LESS="-FiXR"
export PS2="\[\033[0;36m\] --\[\033[0m\]> "
export PS3='> '
export PS4='+ '
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE='history*'
export HISTTIMEFORMAT='%F %T '

export PROMPT_COMMAND="history -a; history -c; history -r"

if [ -z "${VIM_TERMINAL}" ]; then
    case "$TERM" in
    linux|xterm*|rxvt*)
        if [ -n "${SSH_CLIENT}" ] && [ -z "${TMUX}" ]; then
            export PROMPT_COMMAND=${PROMPT_COMMAND}'; printf "\033]0;${HOSTNAME%%.*}: ${PWD##*/}\007"'
        else
            export PROMPT_COMMAND=${PROMPT_COMMAND}'; printf "\033]0;${PWD##*/}\007"'
        fi
      ;;
    screen*)
        if [ -n "${SSH_CLIENT}" ] && [ -z "${TMUX}" ]; then
            export PROMPT_COMMAND=${PROMPT_COMMAND}'; printf "\033k${HOSTNAME%%.*}: ${PWD##*/}\033"'
        else
            export PROMPT_COMMAND=${PROMPT_COMMAND}'; printf "\033k${PWD##*/}\033"'
        fi
      ;;
    *)
      ;;
    esac
fi

if [ -z "${SSH_CONNECTION}" ]; then
    if [ -S /run/user/"${UID}"/gnupg/S.gpg-agent.ssh ]; then
        SSH_AUTH_SOCK=/run/user/"${UID}"/gnupg/S.gpg-agent.ssh
    elif [ -S ~/.gnupg/S.gpg-agent.ssh ]; then
        SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh
    fi
fi
export SSH_AUTH_SOCK

# Source in all shared configs
for x in ~/.config/bash.d/{colors,secrets,aliases,functions}.sh; do
  if [ -e "${x}" ]; then
    source "${x}"
  fi
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ "${UID}" -ne 0 ]; then
    export PS1="${__NEON_YELLOW}${HOSTNAME%%.*} ${__ORANGE}\W${__DARK_GREY}\$(git_branch)${__BLUE_GREEN} \$ ${__RESET}"
else
    export PS1="${__NEON_RED}${HOSTNAME%%.*} ${__NEON_YELLOW}\W${__DARK_GREY}\$(git_branch)${__BLUE_GREEN} \$ ${__RESET}"
fi

# Source host specific stuff
if [ -e "${PLATFORM_BASHRC}" ]; then
  source "${PLATFORM_BASHRC}"
fi

# If this is a subshell under a virtual env, source it again
# TODO: Fix the path nightmare that this causes
if [ ! -z "${VIRTUAL_ENV}" ]; then
    source "${VIRTUAL_ENV}"/bin/activate
fi

