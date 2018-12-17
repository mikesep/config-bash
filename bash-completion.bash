#!/bin/bash

if brew --prefix >/dev/null 2>&1 ; then
  if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ] ; then
    # shellcheck source=/dev/null
    source "$(brew --prefix)/share/bash-completion/bash_completion"
  else
    echo "Missing homebrew bash completion"
  fi
fi
