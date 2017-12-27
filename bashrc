#!/bin/bash

path_to_bashrc="${BASH_SOURCE[0]}"
#echo "This is bashrc in ${path_to_bashrc}"

bash_config_dir="$(dirname "${path_to_bashrc}")"

while read -r file ; do
    # shellcheck source=/dev/null
    source "${bash_config_dir}/${file}"
done << EOD
ansi-escape-codes.bash
bash-completion.bash
file-listing.bash
git-cdtop.bash
prompt.bash
up.bash
EOD

unset path_to_bashrc
unset bash_config_dir
