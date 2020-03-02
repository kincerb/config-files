alias geom='echo "${COLUMNS}x${LINES}"'
alias priv_rsync='rsync -i -r --no-p --no-g --chmod=ugo=rwX -e "ssh" --rsync-path="sudo rsync"'
alias conv_utf8='iconv -f ISO-8859-1 -t UTF-8'
alias gpg_update_tty='gpg-connect-agent updatestartuptty /bye'
