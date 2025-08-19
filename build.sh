#!/bin/bash
# Build 'mpy-cross' and board 'firmware'

build_mpycross() {
	make -C ./fw/micropython/mpy-cross
}

build_firmware() {
# Select appropriate device 'port' and 'board' type (if needed) from
# micropython submodule as the build target before invoking.
#
# see: https://github.com/micropython/micropython/tree/master/ports, for avail. options.
#
# Also required is the actual toolchain for the target arch (e.g. arm-none-eabi-gcc, ...).
# This should be installled from your system repositories.
	local FW_PORT="rp2"
	local FW_BOARD="RPI_PICO"

	echo "* PORT: $FW_PORT"
	echo "* BOARD: $FW_BOARD"

	# Does the specified port exist?
	if [[ ! -d "./fw/micropython/ports/$FW_PORT" ]]; then
		echo "Couldn't find '$FW_PORT' in the ports directory! Exiting ..."
		exit 1
	fi

	make -C "./fw/micropython/ports/$FW_PORT" BOARD="$FW_BOARD"
}

echo "[BUILDING FIRMWARE AND TOOLS]"
echo -e "\n> BUILDING 'MPY-CROSS'" && build_mpycross
echo -e "\n> BUILDING 'FIRMWARE'" && build_firmware
