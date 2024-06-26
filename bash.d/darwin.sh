export BREW_PREFIX=/opt/homebrew
export BREW_BIN="${BREW_PREFIX}/bin"
export EDITOR="${BREW_BIN}/nvim"
export VISUAL="${EDITOR}"

launchctl setenv SSH_AUTH_SOCK "${SSH_AUTH_SOCK}"

bin_paths=("${BREW_BIN}" "${BREW_PREFIX}/sbin")
bin_paths+=("${HOME}/Library/Python/3.10/bin")
bin_paths+=("${HOME}/Library/Python/3.11/bin")
bin_paths+=("${HOME}/.local/fzf/bin")

for bin_path in ${bin_paths[@]}; do
	if [ -d "${bin_path}" ]; then
		if ! [[ "${PATH}" =~ :?"${bin_path}":? ]]; then
			export PATH="${bin_path}:$PATH"
		fi
	fi
done
unset bin_path
unset bin_paths

for _helper in $(compgen -f "${HOME}/.local/share/bash_completion.d/"); do
	if [ -e "${_helper}" ]; then
		source "${_helper}"
	fi
done
unset _helper

for _helper in "${HOME}"/.local/fzf/shell/*.bash; do
	source "${_helper}"
done
unset _helper

alias chrome_canary='(/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --proxy-server=http://127.0.0.1:3128 &>/dev/null &)'
alias vivaldi='(/Applications/Vivaldi.app/Contents/MacOS/Vivaldi --proxy-server=http://127.0.0.1:3128 &>/dev/null &)'
alias xor_decode="python3 -c \"import base64; import sys; print(''.join(chr(ord(x) ^ ord('_')) for x in base64.b64decode(sys.argv[1].replace('{xor}', '')).decode()))\""
alias awk="${BREW_BIN}/awk"
alias sed="${BREW_BIN}/gsed"
alias pg_dump="${BREW_PREFIX}/Cellar/postgresql@12/12.16/bin/pg_dump"
alias nvim_update='nvim -c "PlugUpdate|CocUpdateSync|qa"'

web_app() {
	if [ "${#}" -ne 1 ]; then
		echo -e "Usage:\n web_app [url]"
		echo -e "\n  web_app https://netflix.com"
		return
	fi
	local url="${1}"
	(/Applications/Vivaldi.app/Contents/MacOS/Vivaldi \
		--proxy-server=http://127.0.0.1:3128 \
		--app="${url}" 2>&1 &>/dev/null &)
}

deploy() {
	local _server
	local _project
}

brew_cleanup() {
	for x in /opt/homebrew/Cellar/*; do
		brew cleanup "${x##*/}"
	done
}

pycharm() {
	unset TMUX
	open "${HOME}/Applications/JetBrains Toolbox/PyCharm Professional.app"
}

datagrip() {
	unset TMUX
	open "${HOME}/Applications/JetBrains Toolbox/DataGrip.app"
}

webstorm() {
	unset TMUX
	open "${HOME}/Applications/JetBrains Toolbox/WebStorm.app"
}
