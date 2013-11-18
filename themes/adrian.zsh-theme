function _git_branch() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=003
        else
            local ansi=055
        fi

        branch=$(current_branch)
        if [[ $branch == '' ]]; then
            branch="$(git show-ref --head -s --abbrev | head -n1 2> /dev/null)";
        fi
        if [[ $branch == 'master' ]]; then
            branch=' '
        fi

        echo -n "%K{$ansi}"%F{0}$branch"%f%k "
    fi
}

PROMPT='`_git_branch`%F{038}%~ %f%{$reset_color%}'
