function tail
    command tail -f $argv | bat --plain --paging=never --language=log
end
