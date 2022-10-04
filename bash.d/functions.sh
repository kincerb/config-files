#############################
#   Environment functions   #
#############################
say () {
    if ( tty 2>/dev/null |grep -io pts &>/dev/null ); then
        r='\033[31m'
        y='\033[33m'
        g='\033[32m'
        w='\033[0m'
    fi
    if [ "${1}" == "Error" ]; then
        clr='r'
    elif [ "${1}" == "Warn" ]; then
        clr='y'
    elif [ "${1}" == "Info" ]; then
        clr='w'
    else
        clr='g'
    fi
    echo -e "${!clr}${1}${w}\t${2}"
    if [ -n "${3}" ]; then
        exit "${3}"
    fi
}

git_branch() {
    local cur_branch
    cur_branch=$(git branch 2>/dev/null | awk '{if ($1 == "*") print $2}' |sed 's/[()]//g')
    if [ -n "${cur_branch}" ]; then
        echo " <${cur_branch}>"
    fi
}

set_window_title() {
    history -a; history -c; history -r

    if [ -n "${VIMRUNTIME}" ]; then
        return
    fi
    if [ -n "${TMUX}" ]; then
        if [ -n "${SSH_CLIENT}" ]; then
            printf "\033k ${HOSTNAME%%.*}: ${PWD##*/} \033"
        else
            printf "\033k ${PWD##*/} \033"
        fi
    else
        if [ -n "${SSH_CLIENT}" ]; then
            printf "\033]0; ${HOSTNAME%%.*}: ${PWD##*/} \007"
        else
            printf "\033]0; ${PWD##*/} \007"
        fi
    fi
}


ssh() {
    TERM=xterm-256color command ssh "$@"
    set_window_title
}

vim() {
    stty -ixon; command vim "$@"
    stty -ixoff
}

rvim() {
    if [ "${#}" -ne 2 ]; then
        echo -e "Usage:\n  rvim [server] [file_path|dir_path/]"
        echo -e "\n  rvim nuc.local /home/kincerb/"
        return
    fi
    local server="${1}"
    local file="${2}"
    vim rsync://"${server}"/"${file}"
}

clean_up_sockets() {
    local _socketpath
    # remove all but jump servers
    for _socketpath in $(compgen -f ~/.ssh/socket/); do
        ssh -O exit -S "${_socketpath}" blah &>/dev/null
    done
}

colors() {
    for i in {0..255} ; do
        printf "\x1b[38;5;%smcolour%s\n" "${i}" "${i}"
    done
}

rmssh () {
    if [ -z "$1" ]; then
        echo "Provide server name to remove from .ssh/known_hosts"
        return 1
    fi
    sed -ir "/${1}/d" ~/.ssh/known_hosts
}

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

ssh_forward() {
    if [ "${#}" -ne 3 ]; then
        echo -e "Usage:\n  sshForward localPort remotePort host"
        return
    fi
    local localPort="${1}"
    local remotePort="${2}"
    local host="${3}"
    ssh -tt -NfL "${localPort}":localhost:"${remotePort}" "${host}"
}

tmux_update_ssh () {
    local session="${1:-main}"
    tmux-send-keys.sh -p bash -s "${session}" 'eval $(tmux showenv -s)' 'c-m';
}

pip_update() {
    local pip_bin="${1}"
    for x in $("${pip_bin}" list --outdated --format columns |grep -Ev '^Package|^---' |awk '{print $1}' |xargs); do
        "${pip_bin}" install --upgrade "${x}"
    done
}
