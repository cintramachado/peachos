# PeachOS

PeachOS is a simple operating system developed for educational purposes to learn about OS development (osdev).

## Features

- Custom bootloader written in x86 assembly
- Basic kernel that boots in 16-bit real mode
- Built from scratch to understand low-level system programming

## Prerequisites

To build and run PeachOS, you need:

- `nasm` - The Netwide Assembler
- `make` - Build automation tool
- `qemu-system-i386` - x86 emulator (for testing)

### Installation on Ubuntu/Debian:
```bash
sudo apt-get install nasm make qemu-system-x86
```

### Installation on macOS:
```bash
brew install nasm qemu
```

## Building

To build the OS image:

```bash
make
```

This will create `bin/peachos.bin` containing the bootloader and kernel.

## Running

To run PeachOS in QEMU:

```bash
make run
```

You should see the bootloader message followed by the kernel message.

## Cleaning

To remove all build artifacts:

```bash
make clean
```

## Project Structure

```
peachos/
├── src/
│   ├── boot/
│   │   └── boot.asm      # Bootloader code
│   └── kernel/
│       └── kernel.asm     # Kernel entry point
├── build/                 # Build artifacts (generated)
├── bin/                   # Final OS image (generated)
├── Makefile              # Build system
└── README.md             # This file
```

## Learning Resources

- [OSDev Wiki](https://wiki.osdev.org/)
- [Writing a Simple Operating System from Scratch](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
- [The little book about OS development](https://littleosbook.github.io/)

## License

This project is for educational purposes.