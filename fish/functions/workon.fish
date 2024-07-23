function workon --description "Start work on project"
    argparse a/activate -- $argv

    if test (count $argv) -eq 0
        set -f project_dir $PWD
    else
        set -f project_dir $argv[1]
    end

    cd $project_dir

    if set -ql _flag_activate
        if test -e $project_dir/bin/activate.fish
            set -f venv_dir $project_dir
        else if test -e $project_dir/venv/bin/activate.fish
            set -f venv_dir $project_dir/venv
        else if test -e (path dirname $project_dir)/venv/bin/activate.fish
            set -f venv_dir (path dirname $project_dir)/venv
        end

        if set --query venv_dir
            source $venv_dir/bin/activate.fish
        end
    end

    if test -e $project_dir/.env.fish
        source $project_dir/.env.fish
    end
end
