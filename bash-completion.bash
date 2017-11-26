#!/bin/bash

if [ -d "$(brew --prefix 2>/dev/null)" ] ; then
    # shellcheck source=/dev/null
    source "$(brew --prefix)/share/bash-completion/bash_completion"
fi
