#!/bin/bash

if ls --color >/dev/null 2>&1 ; then
  # GNU ls
  alias ls="ls --color=auto --classify"
else
  # MacOS's BSD ls
  alias ls="ls -G -F"
fi

alias ll="ls -lh"
alias la="ll -a"

alias tree="tree -F"  # -F filetype decoration

function _setup_ls_colors
{
  if ! dircolors >/dev/null 2>&1 ; then
    echo "could not find dircolors -- skipping LS_COLORS customization"
    return 1
  fi

  # shellcheck source=/dev/null
  source <(
    (
      # print defaults
      dircolors --print-database

      # override with my settings
      cat <<EOD
DIR 34    # blue : directory
EXEC 01   # bold : executable

MULTIHARDLINK 36  # cyan : regular file with more than one link

LINK target
# "If you set this to 'target' instead of a numerical value,
# the color is as for the file pointed to."

MISSING 01;31     # bold red : missing target of a symlink

# hide build artifacts by printing them in white
.o   37
.pyc 37
.d   37
EOD
    ) | dircolors - # translate back into LS_COLORS syntax
  )
}
_setup_ls_colors
unset _setup_ls_colors

# Clean dir listing(s)
function l
{
  local path
  if [[ $# == 0 ]]; then
    path="$(pwd)"
  else
    path="$1"
  fi

  clear

  if [[ ! -d $path ]]; then
    echo "$path is not a directory"
    return 1
  fi
  local real_path
  real_path=$(realpath "$path")
  local dirname
  dirname=$(dirname "$real_path")
  local basename
  basename=$(basename "$real_path")
  echo
  printf "%b%s/%b%s%b\n" "${ANSI_BOLD}" "${dirname}" "${ANSI_FG_BLUE}" "${basename}" "${ANSI_RESET}"
  echo
  ll "$path/"
}

# Get the name of the latest (newest) file in a group of files
latest()
{
    command ls -1dt "$@" | head -1
}
