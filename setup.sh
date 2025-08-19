#!/bin/bash
D_VENV=".venv"
BIN_PYTHON=""


locate_python() {
# Python runtime
	if command -v python > /dev/null 2>&1; then
		BIN_PYTHON="$(which python)"
	elif command -v python3 > /dev/null 2>&1; then
		BIN_PYTHON="$(which python3)"
	else
		echo "* Couldn't find python in PATH! Exiting ..."
		exit 1
	fi
	echo "* $($BIN_PYTHON --version) @ \"$(echo $BIN_PYTHON)\""
}

setup_venv() {
	# Virtual Environment
	echo -n "* Locating venv ... "
	if [[ ! -d "$D_VENV" ]]; then
		echo "MISSING"

		echo -n "* Creating virtual environment ... "
		$BIN_PYTHON -m venv "$D_VENV" > /dev/null 2>&1
		if (( $? )); then
			echo "FAIL"
			exit 1
		else
			echo "OK"
		fi
	else
		echo "FOUND"
	fi

	# Source virtual environment
	source "$D_VENV/bin/activate"
	if (( $? )); then
		echo "Failed sourcing VENV! Exiting ..."
		exit 1
	fi
	
	# PIP Upgrade
	echo -n "* Upgrading PIP ... " && pip install --upgrade pip > /dev/null 2>&1
	if (( $? )); then
		echo "ERR"
	else
		echo "OK"
	fi
	
	# PIP Install
	echo -n "* Installing tools ... " && pip install mpremote rshell pyserial > /dev/null 2>&1
	if (( $? )); then
		echo "ERR"
	else
		echo "OK"
	fi
	
	echo -e "DONE\n"
}

fetch_src() {
# Fetch upstream sources
	echo  -n "* Locating submodules ... "
	if [[ ! -f .gitmodules ]]; then
		echo "MISSING"
		echo "Make sure '.gitmodules' is present! Exiting ..."
		exit 1
	else
		echo "FOUND"
	fi

	echo "* Updating submodules ..."
	git submodule update --init --recursive
	if (( $? )); then
		echo -e "* UPDATE: FAIL"
	else
		echo -e "* UPDATE: OK"
	fi

	echo -e "DONE\n"
}


# RUN
echo -e "[PROJECT SETUP]"

echo -e "\n> Python bin" && locate_python
echo -e "\n> Virtual Environment" && setup_venv
echo -e "\n> GIT" && fetch_src

echo "SCRIPT FINISHED"
