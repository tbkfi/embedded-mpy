# Embedded Template: Micropython

An empty project template for micropython projects.

## Usage

You must have the appropriate toolchain installed to use the `build.sh` script, everything else should be handled.

For nuking the device flash, refer to official documentation.

```
1. setup.sh (initialise venv, requirements, and submodules)
2. build.sh (build target port+board firmware, and mpy-cross)
3. flash.sh (copy src to device)
```

Something like `minicom -D /dev/ttyACM0 -b 112500` can be used to open REPL.

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

## License

CC0 | No Rights Reserved

Submodules and payloads may be encumbered.
