function tail --wraps tail
    command tail -f $argv | bat --style="grid,snip" --paging=auto --language=log
end
