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
config=("kitty" "nvim" "macchina")


# ===== FUNCTIONS ================================== #

force_create_symlink() {
	rm -rf "$2$1"
	ln -sv "$PWD/$1" $2 2> /dev/null > /dev/null
	if [ $? -ne 0 ]
	then
		printf "    ${RED}[FAIL]    ${YELLOW}CREATING${BOLD} > $2$1${NC}\n" else
	else
		printf "    ${GREEN}[SUCCESS] ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
	fi
	echo
}

ask_symlink() {
	printf "\t      ${RED}Delete${NC} '$2$1' ${BOLD}(y/N)${NC} " 
	read confirmation
	confirmation="$(echo ${confirmation} | tr 'A-Z' 'a-z')"
	if [[ $confirmation == "y" ]]
	then
		rm -rf "$2$1"
		ln -sv "$PWD/$1" $2 2> /dev/null > /dev/null
		echo
		if [ $? -ne 0 ]
		then
			printf "    ${RED}[FAIL]    ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
		else
			printf "    ${GREEN}[SUCCESS] ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
		fi
	else
			printf "    ${CYAN}[SKIPPED] ${YELLOW}NOT CREATING${BOLD} > $2$1${NC}\n"
	fi
}


create_symlink() {
	ln -sv "$PWD/$1" $2 2> /dev/null > /dev/null
	if [ $? -ne 0 ]
	then
		printf "    ${RED}[FAIL]    ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
		ask_symlink $1 $2
	else
		printf "    ${GREEN}[SUCCESS] ${YELLOW}CREATING${BOLD} > $2$1${NC}\n"
	fi
	echo
}


force_install_all() {
	printf "${PURPLE}
==================================================
\tKayzzel Setup - Symlink Dotfiles
==================================================
${NC}
"

	for conf in "${config[@]}" ; do :
		force_create_symlink "$conf" "$HOME/.config/"
	done

	for conf in "${root[@]}" ; do :
		force_create_symlink "$conf" "$HOME/"
	done
}


install_all() {
	printf "${PURPLE}
==================================================
\tKayzzel Setup - Symlink Dotfiles
==================================================
${NC}
"

	for conf in "${config[@]}" ; do :
		create_symlink "$conf" "$HOME/.config/"
	done

	for conf in "${root[@]}" ; do :
		create_symlink "$conf" "$HOME/"
	done
}

list_config() {
	echo "List config:"
	for conf in "${config[@]}" ; do :
		printf "   - $conf\n"
	done

	for conf in "${root[@]}" ; do :
		printf "   - $conf\n"
	done
}


is_in_array() {
	local elem="$1"
	shift
	local arr=("$@")
	for item in "${arr[@]}"
	do
		if [ "$elem" == "$item" ]; then
			return 0
		fi
	done
	return 1
}


usage()
{
	cat << EOF
usage: $0 PARAM [-o|--one CONFIG] [-f|--force] [-h|--help]

This script does install config files.

OPTIONS:
   PARAM        The param
   -h|--help    Show this message
   -l|--list	list all the configs
   -f|--force   Enable --force
   -o|--one 	install only one config
EOF
}

# ===== CODE ======================================= #



CONFIG=""
FORCE=""

if ! [[ "$1" ]]
then
	install_all
	exit
fi
while [ ! $# -eq 0 ]; do
    case "$1" in
        -o | --one)
			if [ "$CONFIG" ]; then
				echo 'already choose a config'
				exit 1
			elif [ "$2" ]; then
                CONFIG=$2
                shift
            else
                echo '--one requires a value'
                exit 1
            fi
            ;;
        -f | --force)
			if [ "$FORCE" ]; then
				echo '--force already used'
				exit 1
			fi
            FORCE='--force'
            ;;
        -h | --help)
            usage
            exit
            ;;
        -l | --list)
			list_config
            exit
            ;;
        *)
            usage
            exit
            ;;
    esac
    shift
done


if [ "$CONFIG" ]; then
	if  is_in_array "$CONFIG" "${root[@]}"; then
		if [ "$FORCE" ]; then
			force_create_symlink "$CONFIG" "$HOME/"
		else
			create_symlink "$CONFIG" "$HOME/"
		fi
	elif is_in_array "$CONFIG" "${config[@]}"; then
		if [ "$FORCE" ]; then
			force_create_symlink "$CONFIG" "$HOME/.config/"
		else
			create_symlink "$CONFIG" "$HOME/.config/"
		fi
	else
		echo "$CONFIG is not an availaible config"
		exit 1
	fi
else
	if [ "$FORCE" ]; then
		force_install_all
	else
		install_all
	fi
fi
