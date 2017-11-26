#!/bin/bash

# TODO lscolors

alias ls="ls -F" # TODO GNU --color=auto" # --classify
alias ll="ls -lh"
alias la="ll -a"

alias tree="tree -F"  # -F filetype decoration

# Get the name of the latest (newest) file in a group of files
latest()
{
    /bin/ls -1dt "$@" | head -1
}
