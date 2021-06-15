export PYTHON_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
export PYTHON_USER_SITE="${HOME}/.local/lib/python${PYTHON_VER}/site-packages"
export POWERLINE_ROOT="${PYTHON_USER_SITE}"
export POWERLINE_BASHRC="${POWERLINE_ROOT}/powerline/bindings/bash/powerline.sh"
export GOOGLE_CHROME="/opt/google/chrome/google-chrome"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  # shellcheck disable=SC2015
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -e "${POWERLINE_BASHRC}" ]; then
    powerline-daemon -q
fi

chrome_app() {
    if [ "${#}" -ne 1 ]; then
        echo -e "Usage:\n chrome_app [url]"
        echo -e "\n  chrome_app https://netflix.com"
        return
    fi
    local url="${1}"
    ("${GOOGLE_CHROME}" --app="${url}" --app-shell-user=dev.bkincer@gmail.com 2>&1 &>/dev/null &)
}
