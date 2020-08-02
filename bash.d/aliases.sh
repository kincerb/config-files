alias geom='echo "${COLUMNS}x${LINES}"'
alias conv_utf8='iconv -f ISO-8859-1 -t UTF-8'
alias gpg_update_tty='gpg-connect-agent updatestartuptty /bye'
alias priv_rsync='rsync --human-readable --archive --no-p --no-g --chmod=ugo=rwX --exclude=*.swp --exclude=venv/ --exclude=.git/ --exclude=.idea/ -e "ssh -l mwauto" --rsync-path="sudo rsync"'
