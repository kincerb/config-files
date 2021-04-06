# ${HOME}/.bashrc
umask 027

if [ "${TILIX_ID}" ] || [ "${VTE_VERSION}" ]; then
    source /etc/profile.d/vte.sh
fi

export HOST_BASHRC="${HOME}/.config/bash.d/${HOSTNAME%%.*}.sh"

LOCAL_BIN="${HOME}/.local/bin"

if [ -n "${PATH##*${LOCAL_BIN}}" ] && [ -n "${PATH##*${LOCAL_BIN}:*}" ]; then
    export PATH=$PATH:${LOCAL_BIN}
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
export PAGER=less
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

if [ -z "${PROMPT_COMMAND}" ]; then
    export PROMPT_COMMAND="history -a; history -c; history -r"
else
    export PROMPT_COMMAND="${PROMPT_COMMAND}; history -a; history -c; history -r"
fi

if [ -z "${VIM_TERMINAL}" ]; then
    case "$TERM" in
    linux|xterm*|rxvt*)
      export PROMPT_COMMAND=${PROMPT_COMMAND}'; printf "\033]0;${PWD##*/}\007"'
      ;;
    screen*)
      export PROMPT_COMMAND=${PROMPT_COMMAND}'; printf "\033k${PWD##*/}\033"'
      ;;
    *)
      ;;
    esac
fi

# use gpg-agent as ssh agent
if [ -S /run/user/"${UID}"/gnupg/S.gpg-agent.ssh ]; then
    export SSH_AUTH_SOCK=/run/user/"${UID}"/gnupg/S.gpg-agent.ssh
fi

# Source in all shared configs
for x in ~/.config/bash.d/{colors,secrets,aliases,functions}.sh; do
  if [ -e "${x}" ]; then
    source "${x}"
  fi
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Source host specific stuff
if [ -e "${HOST_BASHRC}" ]; then
  source "${HOST_BASHRC}"
fi

if [ "${UID}" -ne 0 ]; then
    if [ ! -z "${my_ps}"  ]; then
        export PS1="${__LIGHT_BLUE}${my_ps} ${__LIGHT_ORANGE}\W${__LIGHT_RED}\$(git_branch)${__BLUE_GREEN} \$ ${__RESET}"
    else
        export PS1="\[\e[0;32m\]\h\[\e[m\] \[\e[0;34m\]\W\[\e[m\] \[\e[0;32m\]\$\[\e[m\] ${__RESET}"
    fi
else
    export PS1="\[\e[0;31m\]\h\[\e[m\] \[\e[0;34m\]\W\[\e[m\] \[\e[0;32m\]\#\[\e[m\] ${__RESET}"
fi

# If this is a subshell under a virtual env, source it again
# TODO: Fix the path nightmare that this causes
if [ ! -z "${VIRTUAL_ENV}" ]; then
    source "${VIRTUAL_ENV}"/bin/activate
fi

