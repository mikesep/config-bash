#!/bin/bash

while read -r file ; do
    # shellcheck source=/dev/null
    source "$(dirname "${BASH_SOURCE[0]}")/${file}"
done << EOD
path.bash
ansi-escape-codes.bash
bash-completion.bash
file-listing.bash
git-cdtop.bash
horizontal-rule.bash
prompt.bash
up.bash
EOD
