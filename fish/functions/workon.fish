function workon --description "Start work on project"
    argparse a/activate -- $argv

    if test (count $argv) -eq 0
        set --function project_dir $PWD
    else
        set --function project_dir $argv[1]
    end

    cd $project_dir

    if test -e $project_dir/.env.fish
        source $project_dir/.env.fish
    end

    if ! set --query _flag_activate
        return 0
    end

    if test -e $project_dir/bin/activate.fish
        set --function venv_dir $project_dir
    else if test -e $project_dir/venv/bin/activate.fish
        set --function venv_dir $project_dir/venv
    else if test -e (path dirname $project_dir)/venv/bin/activate.fish
        set --function venv_dir (path dirname $project_dir)/venv
    end

    if set --query venv_dir
        source $venv_dir/bin/activate.fish
    end

end
