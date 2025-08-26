#!/bin/bash

source_venv() {
# Work inside the project venv
	echo -n "* Finding venv: "
	if [[ -z "$PATH_VENV" ]]; then
		echo "UNSET!"
		return 2
	fi
	if [[ ! -d "$PATH_VENV" ]]; then
		echo "FAIL!"
		echo -e "\nMake sure python venv is up-to-date in '$PATH_VENV'!"
		return 4
	else
		echo "OK"

		echo -n "* Sourcing venv: "
		source "$PATH_VENV/bin/activate" > /dev/null 2>&1
		if (( $? )); then
			echo "FAIL!"
			echo -e "\nSomething went wrong, can't continue!"
			exit 1
		else
			echo "OK"
		fi
	fi
}

check_requirement() {
	echo -n "* $1: "
	if ! command -v "$1" > /dev/null 2>&1; then
		echo "FAIL"
		return 1
	else
		echo "OK"
		return 0
	fi
}

check_requirements() {
# Make sure we have needed base tools
	check_requirement "mpremote"
}

copy_src() {
# Copy source files to device
	if [[ -z "$PATH_SRC" ]]; then
		echo "* PATH_SRC is unset!"
		return 2
	fi
	if [[ ! -d "$PATH_SRC" ]]; then
		echo "* MISSING PATH_SRC !"
		return 4
	fi

	# Flat copy
	for F in "$PATH_SRC"/*.{py,mpy}; do
		if [[ -e "$F" ]]; then
			FNAME="$(basename "$F")"
			mpremote cp "$F" :"$FNAME" > /dev/null 2>&1
			if (( $? )); then
				echo "* '$F' !! '$FNAME'"
			else
				echo "* '$F' -> '$FNAME'"
			fi
		fi
	done
	mpremote reset
}

flash() {
	echo "[FLASHING]"
	echo -e "\n> VENV" && source_venv
	echo -e "\n> TOOLS" && check_requirements
	echo -e "\n> COPYING SRC" && copy_src
	echo "DONE"
}


if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	source .env || exit 1
	flash
fi
