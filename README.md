# DESM-OS
DESM-OS is an operating system under development. It aims to be a learning project and eventually a functional OS.

## Current Features
- Basic bootloader.
- Minimal kernel that prints 'H' to the screen.

## Build Instructions
1. Install `gcc`, `nasm`, and `ld`.
2. Run `make` to build the OS image.
3. Use `qemu-system-i386 -kernel os-image` to test it.

## Roadmap
- Expand the kernel.
- Add basic device drivers.
- Develop a filesystem.
