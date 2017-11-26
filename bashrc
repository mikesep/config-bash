#!/bin/bash

path_to_bashrc="${BASH_SOURCE[0]}"
#echo "This is bashrc in ${path_to_bashrc}"

bash_config_dir="$(dirname "${path_to_bashrc}")"

for file in \
    ansi-escape-codes.bash \
    bash-completion.bash \
    file-listing.bash \
    git-cdtop.bash \
    prompt.bash \
    up.bash \
    ;
do
    # shellcheck source=/dev/null
    source "${bash_config_dir}/${file}"
done

unset path_to_bashrc
unset bash_config_dir
