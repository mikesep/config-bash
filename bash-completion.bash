#!/usr/bin/env bash

if brew --prefix >/dev/null 2>&1 ; then
  if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ] ; then
    BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
    export BASH_COMPLETION_COMPAT_DIR

    # shellcheck source=/dev/null
    source "$(brew --prefix)/share/bash-completion/bash_completion"
  else
    echo "Missing homebrew bash completion"
  fi
fi
