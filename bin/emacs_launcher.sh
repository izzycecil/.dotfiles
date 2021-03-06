#!/usr/bin/env bash

if [ -z "$DISPLAY" ]; then
    IS_GRAPHICAL=true
else
    IS_GRAPHICAL=$(emacs --batch -Q --eval='(if (fboundp '"'"'tool-bar-mode) (message "true") (message "false"))' 2>&1)
fi

if $IS_GRAPHICAL; then
    emacsclient -a "" "$@"
else
    emacsclient -a "" -t "$@"
fi
