set -l possible_envs ~/.local/venvs/*/
# set -l -a possible_envs (fd --type directory venv $HOME)
if test -e ./venv/bin/activate.fish
    set -a possible_envs (echo $pwd)
end
complete -c workon -f
complete -c workon -a (echo $possible_envs)
