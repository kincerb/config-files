export my_ps="r820"
export POWERLINE_ROOT="${HOME}/.local/lib/python3.8/site-packages"
export POWERLINE_BASHRC="${POWERLINE_ROOT}/powerline/bindings/bash/powerline.sh"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

if [ -e "${POWERLINE_BASHRC}" ]; then
    powerline-daemon -q
fi
