export VISUAL=/usr/local/bin/vim
export EDITOR="${VISUAL}"
export PYTHON_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
export PYTHON_SITE_PACKAGES="/usr/local/lib/python${PYTHON_VER}/site-packages"
export POWERLINE_ROOT="${PYTHON_SITE_PACKAGES}/powerline"
export POWERLINE_BASHRC="${POWERLINE_ROOT}/bindings/bash/powerline.sh"

launchctl setenv SSH_AUTH_SOCK "${SSH_AUTH_SOCK}"

if ! [[ "${PATH}" =~ "/usr/local/sbin" ]]; then
    export PATH=$PATH:/usr/local/sbin
fi

alias xor_decode="python3 -c \"import base64; import sys; print(''.join(chr(ord(x) ^ ord('_')) for x in base64.b64decode(sys.argv[1].replace('{xor}', '')).decode()))\""
alias awk=/usr/local/bin/gawk
alias sed=/usr/local/bin/gsed

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if [ -e "${POWERLINE_BASHRC}" ]; then
    powerline-daemon -q
fi

brew_cleanup() {
    for x in /usr/local/Cellar/*; do
        brew cleanup "${x##*/}"
    done
}

pycharm() {
    unset TMUX
    open "/Users/kincerb/Applications/JetBrains Toolbox/PyCharm Professional.app"
}

datagrip() {
    unset TMUX
    open "/Users/kincerb/Applications/JetBrains Toolbox/DataGrip.app"
}

webstorm() {
    unset TMUX
    open "/Users/kincerb/Applications/JetBrains Toolbox/WebStorm.app"
}
