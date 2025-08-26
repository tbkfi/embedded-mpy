#!/bin/bash

build_mpycross() {
	if [[ -z "$PATH_MPY" ]]; then
		echo "* PATH_MPY is unset!"
		return 2
	else
		if [[ -d "$PATH_MPY/mpy-cross" ]]; then
			make -C "$PATH_MPY/mpy-cross"
		else 
			echo "* MISSING BUILD TARGET !"
			return 4
		fi
	fi
}

build_firmware() {
# Building naturally requires the respective toolchain (e.g. arm-none-eabi-gcc)
# for your target arch.
	if [[ -z "$PATH_MPY" ]]; then
		echo "* PATH_MPY is unset!"
		return 2
	fi
	if [[ -z "$MPY_FW_PORT" ]]; then
		echo "* MPY_FW_PORT is unset!"
		return 2
	fi
	if [[ ! -d "$PATH_MPY/ports/$MPY_FW_PORT" ]]; then
		echo "* MISSING PORT TARGET '$MPY_FW_PORT' !"
		return 4
	fi

	echo "* PORT: $FW_PORT"
	[[ ! -z "$MPY_FW_BOARD" ]] && echo "* BOARD: $MPY_FW_BOARD" || echo "* BOARD: UNSET"

	make -C "$PATH_MPY/ports/$MPY_FW_PORT" BOARD="$MPY_FW_BOARD"
}

build() {
	echo "[BUILDING FIRMWARE AND TOOLS]"
	echo -e "\n> BUILDING 'MPY-CROSS'" && build_mpycross
	echo -e "\n> BUILDING 'FIRMWARE'" && build_firmware
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	source .env || exit 1
	build
fi
