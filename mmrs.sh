#!/usr/bin/env bash

declare -A MMRS
MMRS["Linking tmux"]="$HOME/.tmux.conf $HOME/.tmux.conf.old $DOT/.tmux.conf"
MMRS["Linking tmtmuxinatorux"]="$HOME/.config/tmuxinator $HOME/.config/tmuxinator.old $DOT/tmuxinator"
MMRS["Linking zsh"]="$HOME/.zshrc $HOME/.zshrc.old $DOT/.zshrc"
MMRS["Linking sshconf"]="$HOME/.ssh/config.d $HOME/.ssh/config.d.old $DOT/.ssh/config.d"