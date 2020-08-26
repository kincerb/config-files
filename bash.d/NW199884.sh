export my_ps="mac"
export HOMEBREW_GITHUB_API_TOKEN="de80bed57fed2ee501671dafdf22b8ff61d95b63"
export PATH=${PATH}:${HOME}/Library/Python/3.8/bin
export DTR=dtr.aws.e1.nwie.net
export DORG="${DTR}"/mwautomation
export VISUAL=/usr/local/bin/vim
export EDITOR="${VISUAL}"
export POWERLINE_ROOT="${HOME}/Library/Python/3.8/lib/python/site-packages"
export POWERLINE_BASHRC="${POWERLINE_ROOT}/powerline/bindings/bash/powerline.sh"

if [ -z "${SSH_CONNECTION}" ]; then
    if [ -e ~/.gnupg/S.gpg-agent.ssh ]; then
        export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh
    fi
fi

alias socket='ssh -Nf elvmt0048 2>/dev/null'
alias hulu='chrome_app https://hulu.com'
alias chrome='(/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --proxy-pac-url=http://127.0.0.1:8010/iboss.pac 2>&1 &>/dev/null &)'
alias music='chrome_app https://music.youtube.com'
alias amazon='chrome_app https://amazon.com'
alias google_play='chrome_app https://play.google.com'
alias netflix='chrome_app https://netflix.com'
alias reset_dns_cache="sudo killall -HUP mDNSResponder"
alias backup_lifecycle_db="socket; rsync -av elvmt0048:/webdata/backups/mysql_backup/ /Volumes/google/backups/work/lifecycle/"
alias dlogin="docker login ${DTR}"
alias xor_decode="python3 -c \"import base64; import sys; print(''.join(chr(ord(x) ^ ord('_')) for x in base64.b64decode(sys.argv[1].replace('{xor}', '')).decode()))\""
alias awk=/usr/local/bin/gawk
alias sed=/usr/local/bin/gsed

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if [ -e "${POWERLINE_BASHRC}" ]; then
    powerline-daemon -q
    # POWERLINE_BASH_CONTINUATION=1
    # POWERLINE_BASH_SELECT=1
    # source "${POWERLINE_BASHRC}"
fi

d_push() {
    local repo="${1}"
    docker push "${DORG}"/"${repo}"
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

chrome_app() {
    if [ "${#}" -ne 1 ]; then
        echo -e "Usage:\n chrome_app [url]"
        echo -e "\n  chrome_app https://netflix.com"
        return
    fi
    local url="${1}"
    (/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --app="${url}"
    --app-shell-user=dev.bkincer@gmail.com --proxy-pac-url=http://127.0.0.1:8010/iboss.pac 2>&1 &>/dev/null &)
}

__proxy() {
    local proxy_var x
    if [ "${#}" -ne 1 ]; then
        echo -e "Usage:\n  proxy [ desktop-nw | nuc | cntlm | off | status | http:// ]"
        return
    fi
    if [[ "${1}" =~ ^http://|desktop-nw|cntlm|nuc ]]; then
        if [ "${1}" == "desktop-nw" ]; then
            proxy_var=http://10.200.162.15:8080
        elif [ "${1}" == "nuc" ]; then
            proxy_var=http://192.168.86.2:3128
        elif [ "${1}" == "cntlm" ]; then
            proxy_var=http://127.0.0.1:3128
        else
            proxy_var="${1}"
        fi
        for x in HTTPS HTTP ALL FTP; do
            export ${x}_PROXY="${proxy_var}"
        done
        for x in https http all ftp; do
            export ${x}_proxy="${proxy_var}"
        done
        export NO_PROXY=localhost,127.0.0.0/8,nwie.net,nwideweb.net,nwielab.net,ent.nwie.net,192.168.0.0/16,10.0.0.0/8
        export no_proxy=localhost,127.0.0.0/8,nwie.net,nwideweb.net,nwielab.net,ent.nwie.net,192.168.0.0/16,10.0.0.0/8
    elif [ "${1}" == "off" ]; then
        for x in HTTPS HTTP ALL FTP NO; do
            unset ${x}_PROXY
        done
        for x in https http all ftp no; do
            unset ${x}_proxy
        done
        #unset GIT_PROXY_COMMAND
    elif [ "${1}" == "status" ]; then
        for x in HTTPS HTTP ALL FTP NO; do
            echo "  ${x}_PROXY=$(eval echo \$${x}_PROXY)"
        done
        echo ""
        for x in https http all ftp no; do
            echo "  ${x}_proxy=$(eval echo \$${x}_proxy)"
        done
        echo "  GIT_PROXY_COMMAND=${GIT_PROXY_COMMAND}"
    else
        echo -e "Usage:\n  __proxy [ squid | cntlm | off | status ]"
    fi
}

dmgr() {
    local server="${1}"
    local domains="nwie.net server.nwie.net server.nwielab.net"
    local found=false
    for domain in ${domains}; do
        if (nslookup "${server}.${domain}" &>/dev/null); then
            found=true
            chrome_app "https://${server}.${domain}:9043/ibm/console/logon.jsp"
            break
        fi
    done
    if ! "${found}"; then
        say ERROR "Could not find ${server}'s IP address"
    fi
}

reverse_nuc_proxy() {
    if [ "${#}" -ne 2 ]; then
        echo -e "Usage:    reverse_nuc_proxy host_[interface:]port host"
        echo -e "\n  Direct traffic on the all of the remote's interfaces"
        echo -e "    reverse_nuc_proxy 3128 ljtp000063"
        echo -e "\n  Only direct traffic on the remote's localhost"
        echo -e "    reverse_nuc_proxy 127.0.0.1:3128 ljtp000063"
        return
    fi
    local host_listen_address="${1}"
    local host="${2}"
    ssh -tt -NfR "${host_listen_address}":192.168.86.2:3128 "${host}"
}
