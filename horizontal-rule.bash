#!/usr/bin/env bash

# Adapted from http://brettterpstra.com/2015/02/20/shell-trick-printf-rules/

function rule {
  local spaces
  spaces=$(printf "%*s" "$(tput cols)" "x" | tr x " ")
  echo "${spaces// /${1:--}}"
}

function rulem {
  if [ $# -eq 0 ]; then
    echo "Usage: $0 MESSAGE [RULE_CHARACTER]"
    return 1
  fi

  # Fill line with ruler character ($2, default "-"),
  # reset cursor, move 2 cols right, print message
  #printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
  local spaces
  spaces=$(printf "%*s" "$(tput cols)" "x" | tr x " ")
  printf -- "%s%b[ %s ]\n" "${spaces// /${2:--}}" "\r\033[2C" "$1"
}

# rule with message in bold
function rulemb {
  if [ $# -eq 0 ]; then
    echo "Usage: $0 MESSAGE [RULE_CHARACTER]"
    return 1
  fi

  # Fill line with ruler character ($2, default "-"),
  # reset cursor, move 2 cols right, print message
  #printf -v _hr "%*s" $(tput cols) && echo -en ${_hr// /${2--}} && echo -e "\r\033[2C$1"
  local spaces
  spaces=$(printf "%*s" "$(tput cols)" "x" | tr x " ")
  printf -- "%s%b[ %b%s%b ]\n" "${spaces// /${2:--}}" "\r\033[2C" "\033[1m" "$1" "\033[0m"
}
