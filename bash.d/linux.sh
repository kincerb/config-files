export EDITOR=nvim
export GPG_TTY=$(tty)
export VISUAL="${EDITOR}"

# if [ "${TILIX_ID}" ] || [ "${VTE_VERSION}" ]; then
#     source /etc/profile.d/vte.sh
# fi

chrome_app() {
    if [ "${#}" -ne 1 ]; then
        echo -e "Usage:\n chrome_app [url]"
        echo -e "\n  chrome_app https://netflix.com"
        return
    fi
    local url="${1}"
    ("google-chrome-stable" --app="${url}" --app-shell-user=dev.bkincer@gmail.com 2>&1 &>/dev/null &)
}
# vim:ft=sh
