#!/usr/bin/env bash

# ANSI codes for use with printf
# (or echo -e, though the OpenBSD xterm man page[1] says printf is more portable)
#
# [1]: https://man.openbsd.org/xterm 

# Reference: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

# '\033' is escape

ANSI_CSI="\\033["

if [ -n "${TEST_ANSI_ESCAPE_CODES}" ] ; then
    # $1 = name
    # $2 = escape
    _test_ansi_single_escape()
    {
        local reset="${ANSI_CSI}0m"
        printf '%-10s %b%s%b\n' "${2}" "${2}" "${1}" "${reset}"
    }
fi

_make_ansi_sgr()
{
    local params=(
        RESET \
        BOLD \
        FAINT \
        ITALIC \
        UNDERLINE \
        SLOW_BLINK \
        RAPID_BLINK \
        REVERSE_VIDEO \
        )
    local i
    for ((i = 0 ; i < ${#params[@]} ; i++)) ; do
        declare -g "ANSI_${params[$i]}=${ANSI_CSI}${i}m"

        if [ -n "${TEST_ANSI_ESCAPE_CODES}" ] ; then
            local var="ANSI_${params[$i]}"
            _test_ansi_single_escape "${var}" "${!var}"
        fi
    done
}
_make_ansi_sgr
unset _make_ansi_sgr

_make_ansi_colors()
{
    local colors=(
        BLACK
        RED
        GREEN
        YELLOW
        BLUE
        MAGENTA
        CYAN
        WHITE
        )
    local i
    for ((i = 0 ; i < ${#colors[@]} ; i++)) ; do
        declare -g "ANSI_FG_${colors[i]}=${ANSI_CSI}$((30+i))m"
        declare -g "ANSI_BG_${colors[i]}=${ANSI_CSI}$((40+i))m"
        declare -g "ANSI_FG_BRIGHT_${colors[i]}=${ANSI_CSI}1;$((30+i))m"
        declare -g "ANSI_BG_BRIGHT_${colors[i]}=${ANSI_CSI}$((100+i))m"
    done

    if [ -n "${TEST_ANSI_ESCAPE_CODES}" ] ; then
        local variant
        for variant in FG BG {FG,BG}_BRIGHT ; do
            local color
            for color in "${colors[@]}" ; do
                local var="ANSI_${variant}_${color}"
                _test_ansi_single_escape "${var}" "${!var}"
            done
        done
    fi
}
_make_ansi_colors
unset _make_ansi_colors

if [ -n "${TEST_ANSI_ESCAPE_CODES}" ] ; then
    unset _test_ansi_single_escape
fi
