function tail --wraps tail --wraps bat
    command tail -f $argv | bat --style="grid,snip" --paging=auto --language=log
end
