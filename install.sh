#! /bin/bash

root=(".zshrc" "startup.sh" ".tmux.conf")
components=("kitty" "nvim" "macchina")

for comp in "${components[@]}" ; do :
	ln -sv "$PWD/$comp/.config/$comp" "$HOME/.config/"
done

for element in "${root[@]}" ; do :
	ln -sv "$PWD/$element" "$HOME/"
done
