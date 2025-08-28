# Embedded Template: Micropython

An empty project template for micropython projects.

## Usage

Firstly `cp ./.env.template ./.env`, and modify the variables to suit your target device and environment.
If the `.env` file is not present, the helper scripts will complain and quit.

You must have the appropriate toolchain installed to use the `build.sh` script, everything else should be handled.

You may wish to reset the device flash before starting a new project, to do this refer to the board's official documentation.
Or see if the "Flash Reset" section has an entry for your board.

```
1. setup.sh (initialise venv, requirements, and submodules)
2. build.sh (build target port+board firmware, and mpy-cross)
3. flash.sh (copy src to device)
```

Something like `minicom -D /dev/ttyACM0 -b 112500` can be used to open REPL, which is a good way to
test if the firmware was flashed and functions correctly if you don't have a led for blinky, for example.

## Imports

The `mpy-cross` cross-compiler allows creating `.mpy` files, which can be stored on-device and imported in code using `import foo`.

Its source lives in the micropython submodule at: `/fw/micropython/mpy-cross/`, and can be built within the directory simply by invoking `make` or the provided `build.sh` script. 

Running `./build/mpy-cross foo.py` will output the mpy-file.

[Documentation](https://github.com/micropython/micropython/tree/master/mpy-cross)

## Flash Reset

### Raspberry Pi Pico (RP2350 & RP2040)

Hold BOOTSEL, and plug the device into a computer. Mount the block device into a path, and
copy `/fw/flash_nuke.uf2` into the blkdev root.

[Documentation](https://www.raspberrypi.com/documentation/microcontrollers/pico-series.html#resetting-flash-memory)

## Why?

A low threshold to get started on a project, and a reliable base to iterate on makes development easier to start and continue.
As someone who prefers the CLI, and doesn't use heavier IDEs for programming (neovim btw), this was a simple way to create a relatively standard
layout for interfacing with an embedded device while minimising the dependencies and unneeded middleware.

## License

CC0 | No Rights Reserved

Submodules and payloads may be encumbered.
