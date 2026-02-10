#! /bin/bash

# ===== COLORS ===================================== #


# Bold Color
BLACK='\033[1;30m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'

# Color
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

# Bold
BOLD='\033[0m\033[1m' # No color

# No color
NC='\033[0m'


# ===== CONFIGS ==================================== #

root=(".zshrc" "startup.sh" ".tmux.conf" ".w3m")
components=("kitty" "nvim" "macchina")


# ===== FUNCTIONS ================================== #

force_symlink() {
	read -p "Delete '$2$1' (y/N) " confirmation
	confirmation="$(echo ${confirmation} | tr 'A-Z' 'a-z')"
	if [[ $confirmation == "y" ]]
	then
		rm -rf "$2$1"
		ln -sv "$PWD/$1" $2 2> /dev/null > /dev/null
		if [ $? -ne 0 ]
		then
			printf "    ${RED}[FAIL]    ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
		else
			printf "    ${GREEN}[SUCCESS] ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
		fi
	fi
}


create_symlink() {
	ln -sv "$PWD/$1" $2 2> /dev/null > /dev/null
	if [ $? -ne 0 ]
	then
		printf "    ${RED}[FAIL]    ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
		force_symlink $1 $2
	else
		printf "    ${GREEN}[SUCCESS] ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
	fi
}


# ===== CODE ======================================= #

printf "${PURPLE}
==================================================
\tKayzzel Setup - Symlink Dotfiles
==================================================
${NC}
"

for comp in "${components[@]}" ; do :
	create_symlink "$comp/" "$HOME/.config/"
done

for element in "${root[@]}" ; do :
	create_symlink "$element" "$HOME/"
done
