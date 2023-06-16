#!/usr/bin/env bash

declare -A MMRS
MMRS["Linking tmux"]="$HOME/.tmux.conf $HOME/.tmux.conf.old $DOT/tmux/.tmux.conf"
MMRS["Linking tmtmuxinatorux"]="$HOME/.config/tmuxinator $HOME/tmuxinator/.config/tmuxinator.old $DOT/tmuxinator"
MMRS["Linking zsh"]="$HOME/.zshrc $HOME/.zshrc.old $DOT/zsh/.zshrc"
MMRS["Linking sshconf"]="$HOME/.ssh/config.d $HOME/.ssh/config.d.old $DOT/ssh/.ssh/config.d"