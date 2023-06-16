#!/usr/bin/env zsh

(crontab -l 2>/dev/null || true; echo "0 * * * * $HOME/.sbcns/utils/store/backup.sh") | crontab -
