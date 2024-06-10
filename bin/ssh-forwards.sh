#!/opt/homebrew/bin/bash

FORWARDERS=("forward-to-wireguard" "forward-to-vm")

stop() {
	local _pids
	local _pid
	for _pid in $(pgrep -U ${UID} -f ssh-forwards.sh | xargs); do
		_pids+=("${_pid}")
	done
}

main() {
	local _host
	while true; do
		for _host in ${FORWARDERS[@]}; do
			if (ssh -O check "${_host}" 2>&1 | grep "No such" &>/dev/null); then
				ssh -Nnf "${_host}"
			fi
		done
		sleep 30
	done
	stop
}

main
