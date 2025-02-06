# DESM-OS

DESM-OS is a hobby operating system project focused on learning and developing a custom OS from scratch.

## Current Features
- 16-bit bootloader with password protection
- 32-bit kernel with basic screen rendering
- Modular system architecture

## Build Requirements
- gcc (32-bit)
- nasm
- ld
- qemu (optional, for testing)

## Build Instructions
1. Install dependencies
2. Run `make`
3. Test with `make run` or `qemu-system-i386 -kernel os-image`

## Development Roadmap
- Expand kernel functionality
- Implement memory management
- Add device drivers
- Develop basic filesystem
- Create user space environment

## Contributing
1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push and create pull request

## License
MIT License
