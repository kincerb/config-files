export my_ps="pixelbook"
export SSH_AUTH_SOCK=/var/run/user/1000/gnupg/S.gpg-agent.ssh
export PATH="${PATH}:${HOME}/.local/bin"
export POWERLINE_ROOT="${HOME}/.local/lib/python3.7/site-packages"
export POWERLINE_BASHRC="${POWERLINE_ROOT}/powerline/bindings/bash/powerline.sh"
if [ -e "${POWERLINE_BASHRC}" ]; then
    powerline-daemon -q
    # POWERLINE_BASH_CONTINUATION=1
    # POWERLINE_BASH_SELECT=1
    # source "${POWERLINE_BASHRC}"
fi
