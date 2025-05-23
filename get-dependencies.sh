#!/bin/bash
set -euo pipefail

#
# Add dependencies URLs here
#
DEPENDENCIES="
https://github.com/robert-strandh/Clonedijk
https://github.com/s-expressionists/Concrete-Syntax-Tree
https://github.com/s-expressionists/Eclector
https://github.com/s-expressionists/Khazern
https://github.com/s-expressionists/Trucler
https://github.com/s-expressionists/Clostrum
https://github.com/s-expressionists/Incless
https://github.com/s-expressionists/Invistra
https://github.com/s-expressionists/ctype
https://github.com/yitzchak/trivial-package-locks
https://gitlab.common-lisp.net/alexandria/alexandria
https://github.com/scymtym/architecture.builder-protocol.git
https://github.com/scymtym/s-expression-syntax.git
https://github.com/robert-strandh/Iconoclast.git
https://github.com/robert-strandh/Common-boot.git
https://github.com/robert-strandh/Common-macros.git
https://github.com/robert-strandh/Parcl.git
https://github.com/s-expressionists/Ecclesia
https://github.com/robert-strandh/Predicament.git
https://github.com/robert-strandh/Regalia.git
https://github.com/robert-strandh/Clostrophilia.git
https://github.com/robert-strandh/Acclimation
"

PROJECTS_DIRECTORY=${1:-"$HOME/quicklisp/local-projects/"}

if [ ! -d "$PROJECTS_DIRECTORY" ]; then
    cat <<EOF
Usage: $0 [PROJECTS_DIRECTORY].

You did not supply a directory to download dependencies into;
the default directory "$PROJECTS_DIRECTORY" does not exist.

EOF
    exit 1
fi

pushd "$PROJECTS_DIRECTORY"

for url in $DEPENDENCIES; do
    repository_name=`basename $url`

    if [ -d "$repository_name" ]; then
        echo " * pulling updates for $repository_name";
        pushd $repository_name
        git pull
        popd
    else
        echo " * cloning $repository_name";
        git clone $url
    fi
done

cat <<EOF
Done.

Run (ql:register-local-projects) from your REPL to add
any new systems to your environment.

EOF
