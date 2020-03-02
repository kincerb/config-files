# ${HOME}/.bashrc
umask 027
export HOST_BASHRC="${HOME}/.config/bash.d/${HOSTNAME%%.*}.sh"
export PATH="${PATH}":/usr/local/sbin:"${HOME}"/bin

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

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
# shellcheck disable=SC2155
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

# use gpg-agent as ssh agent
if [ -s /run/user/"${UID}"/gnupg/S.gpg-agent.ssh ]; then
  export SSH_AUTH_SOCK=/run/user/"${UID}"/gnupg/S.gpg-agent.ssh
fi

# use screen-256color for tmux sessions
if [ -z "${TMUX}" ]; then
  export TERM=xterm-256color
else
  export TERM=screen-256color
fi

# fancy prompt colors
PS_RESET="\[$(tput sgr0)\]"
PS_YELLOW="\[$(tput setaf 154)\]"
PS_GIT="\[$(tput setaf 45)\]"
PS_PWD="\[$(tput setaf 147)\]"

# Source in all shared configs
for x in ~/.config/bash.d/{secrets,aliases,functions,fzf}.sh; do
  if [ -e "${x}" ]; then
    # shellcheck disable=SC1090
    source "${x}"
  fi
done

# Source host specific stuff
if [ -e "${HOST_BASHRC}" ]; then
  # shellcheck disable=SC1090
  source "${HOST_BASHRC}"
fi

if [ "${UID}" -ne 0 ]; then
  # shellcheck disable=SC2154
  if [ -n "${my_ps}" ]; then
    export PS1="${PS_YELLOW}${my_ps} ${PS_PWD}\W${PS_GIT}\$(git_branch)${PS_YELLOW} \$ ${PS_RESET}"
  else
    export PS1="\[\e[0;32m\]\h\[\e[m\] \[\e[0;34m\]\W\[\e[m\] \[\e[0;32m\]\$\[\e[m\] ${PS_RESET}"
  fi
else
  export PS1="\[\e[0;31m\]\h\[\e[m\] \[\e[0;34m\]\W\[\e[m\] \[\e[0;32m\]\#\[\e[m\] ${PS_RESET}"
fi

