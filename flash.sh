#!/bin/bash
# Copy files from '/src' to device.


source_venv() {

	local PATH_VENV="./.venv"
	echo -n "* Finding venv: "
	if [[ ! -d "$PATH_VENV" ]]; then
		echo "FAIL!"
		echo -e "\nMake sure python venv is up-to-date in '$PATH_VENV'!"
		exit 1
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

check_requirements() {
# Make sure we have needed base tools

	echo -n "* mpremote: "
	if ! command -v mpremote > /dev/null 2>&1; then
		echo "FAIL"
	else
		echo "OK"
	fi
}

copy_src() {
# Copy source files to device
	local PATH_SRC="./src"

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

echo "[FLASHING]"
echo -e "\n> VENV" && source_venv
echo -e "\n> TOOLS" && check_requirements
echo -e "\n> COPYING SRC" && copy_src

echo "DONE"
