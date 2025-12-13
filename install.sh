#! /bin/bash

root=(".zshrc" "stratup.sh" ".tmux.conf")
components=("nvim")

for comp in "${components[@]}" ; do :
	ln -sv "$PWD/$comp.config/$comp" "$HOME/.config/"
done

for element in "${root[@]}" ; do :
	ln -sv "$PWD/$element" "$HOME/"
done
