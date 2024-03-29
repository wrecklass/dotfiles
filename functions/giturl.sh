#!/bin/bash

# Open current git repo in browser
giturl() {
    if command -v cygstart &> /dev/null; then
        START=cygstart
    elif command -v xdg-open &> /dev/null; then
        START=xdg-open
    else
        START=open
    fi
    if git status &> /dev/null  ; then
        url="$(git remote -v | grep origin | head -1 | awk '{print $2}' | sed -e 's/git@//')"
        if [[ "$url" != *"https"* ]];then
            # Convert "github.com:user/repo" to "https://github.com/user/repo"
            url="https://${url//:/\/}"
        fi
        ${START} "$url"
    else
        echo "$PWD is not a git repository."
    fi
}
