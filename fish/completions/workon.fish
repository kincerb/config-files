set --local possible_envs (fd --type directory --unrestricted --max-depth 1 . "$HOME/.local/venvs")

for _dirname in (fd --type directory --unrestricted --exclude "site-packages" --exclude ".mypy_cache" --format "{//}" "^(venv|.git)\$" "$HOME/Projects")
    if not contains $_dirname $possible_envs
        set --prepend possible_envs $_dirname
    end
end

complete --command workon --no-files
complete --command workon --short-option n
complete --command workon --long-option no-activate
complete --command workon --arguments --keep-order (echo $possible_envs)
