#!/usr/bin/env bash

# This has to be a bash function to make cd affect the shell.
function git-cdtop
{
    if git rev-parse --show-cdup 2>/dev/null ; then
        cd "$(git rev-parse --show-cdup)" || return
    fi
}
