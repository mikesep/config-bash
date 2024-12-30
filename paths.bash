#!/usr/bin/env bash

_prefix_path() {
    var="${1}"
    dir="${2}"

    if [[ -d "${dir}" ]] ; then
        declare -g "${var}=${dir}${!var:+:${!var}}"
    fi
}

export INFOPATH
_prefix_path INFOPATH /opt/homebrew/share/info

export MANPATH
_prefix_path MANPATH /opt/homebrew/share/man

export PATH
_prefix_path PATH /opt/homebrew/sbin
_prefix_path PATH /opt/homebrew/bin
_prefix_path PATH ~/go/bin
_prefix_path PATH ~/bin

unset -f _prefix_path
