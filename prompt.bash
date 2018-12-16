#!/bin/bash

# shellcheck source=ansi-escape-codes.bash
source "$(dirname "${BASH_SOURCE[0]}")/ansi-escape-codes.bash"

# Command Timing -- see https://stackoverflow.com/a/1862762

_prompt_sec_to_hmmss()
{
    printf '%d:%02d:%02d' \
        $(( $1 / 3600 )) \
        $(( ($1 / 60) % 60 )) \
        $(( $1 % 60 ))
}

_prompt_timer_start()
{
    # Record the start time for the first non-nested start time.
    _prompt_timer_start_seconds=${_prompt_timer_start_seconds:-${SECONDS}}
}

_prompt_timer_stop()
{
    local seconds_elapsed=$(( SECONDS - _prompt_timer_start_seconds ))

    _prompt_timer_display_value=$(_prompt_sec_to_hmmss ${seconds_elapsed})

    unset _prompt_timer_start_seconds
}

trap '_prompt_timer_start' DEBUG

PROMPT_COMMAND=_prompt_timer_stop

# ------------------------------------------------------------------------------

_prompt_construct_ps1()
{
    local exit_code="$?"
    local exit_date="$1"
    local hostname="$2"
    local nice_path="$3"

    local heavy_checkmark_char=$'\xE2\x9C\x94'  # u2714 heavy checkmark
    local heavy_ballot_x_char=$'\xE2\x9C\x98'   # u2718 heavy ballot X

    # \x01 starts non-printing chars and \x02 ends them,
    # as explained in https://superuser.com/a/301355.

    # TODO window title?

    printf '\x01%b\x02' "${ANSI_RESET}"

    # Results of last command

    if [ ${exit_code} == 0 ] ; then
        printf '\x01%b\x02%b' \
            "${ANSI_FG_WHITE}" \
            "${heavy_checkmark_char}"
    else
        printf '\x01%b\x02%b' \
            "${ANSI_FG_RED}" \
            "${heavy_ballot_x_char}"
    fi
    printf ' $?=%-3d  %s    %s' \
        "${exit_code}" \
        "${_prompt_timer_display_value}" \
        "${exit_date}"

    printf '\x01%b\x02\n' "${ANSI_RESET}"

    # Host, git, path

    printf '\x01%b\x02%s\x01%b\x02%b %s\n' \
        "${ANSI_BOLD}" \
        "${hostname}" \
        "${ANSI_RESET}" \
        "$(__git_ps1)" \
        "${nice_path}"

    # Dollar prompt

    printf '\x01%b\x02$\x01%b\x02 ' \
        "${ANSI_BOLD}" \
        "${ANSI_RESET}"
}

PS1="\$(_prompt_construct_ps1 '\\D{%a %b %e %k:%M:%S %Z}' '\\h' '\\w')"

# Exporting these is not necessary, but it does silence shellcheck's SC2034.
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"
