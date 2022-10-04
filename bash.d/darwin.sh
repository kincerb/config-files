export EDITOR=/usr/local/bin/nvim
export VISUAL="${VISUAL}"

launchctl setenv SSH_AUTH_SOCK "${SSH_AUTH_SOCK}"

for bin_path in "/usr/local/sbin" "${HOME}/.krew/bin"; do
    if [ -d "${bin_path}" ]; then
        if ! [[ "${PATH}" =~ "${bin_path}" ]]; then
            export PATH="${bin_path}:$PATH"
        fi
    fi
done
unset bin_path

alias chrome_canary='(/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --proxy-server=http://wireguard01.lan:3128 2>&1 &>/dev/null &)'
alias xor_decode="python3 -c \"import base64; import sys; print(''.join(chr(ord(x) ^ ord('_')) for x in base64.b64decode(sys.argv[1].replace('{xor}', '')).decode()))\""
alias awk=/usr/local/bin/gawk
alias sed=/usr/local/bin/gsed

for bash_helper in "/usr/local/etc/profile.d/bash_completion.sh" \
    $(compgen -f /usr/local/etc/bash_completion.d/); do
    if [ -e "${bash_helper}" ]; then
        source "${bash_helper}"
    fi
done
unset bash_helper

if [ -n "${ITERM_SESSION_ID}" ] && [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

chrome_app() {
    if [ "${#}" -ne 1 ]; then
        echo -e "Usage:\n chrome_app [url]"
        echo -e "\n  chrome_app https://netflix.com"
        return
    fi
    local url="${1}"
    (/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary \
        --proxy-server=http://wireguard01.lan:3128 \
        --app="${url}" \
        --app-shell-user=dev.bkincer@gmail.com 2>&1 &>/dev/null &)
}

deploy() {
    local _server
    local _project
}

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
