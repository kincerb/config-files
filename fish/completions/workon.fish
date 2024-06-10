set -l possible_envs (fd --type directory --max-depth 1 . "$HOME/.local/venvs")

for _dirname in (fd --type directory --unrestricted --exclude "site-packages" --exclude ".mypy_cache" --format "{//}" "^(venv|.git)\$" "$HOME/Projects")
    if not contains $_dirname $possible_envs
        set -a possible_envs $_dirname
    end
end

complete -c workon -f
complete -c workon -l jump
complete -c workon -l activate
complete -c workon -a (echo $possible_envs)
