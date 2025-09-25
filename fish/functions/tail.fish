function tail --wraps tail --wraps bat
    command tail -f $argv | bat --paging=never --language=log --style=grid,snip
end
