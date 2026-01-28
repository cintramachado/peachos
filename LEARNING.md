# Learning Path for OS Development

This document outlines a suggested learning path for studying operating system development with PeachOS.

## Phase 1: Bootloader and Basic Setup (Current)
- [x] Understanding BIOS boot process
- [x] Writing a simple bootloader in x86 assembly
- [x] Loading and jumping to kernel code
- [x] Building and testing with QEMU

## Phase 2: 16-bit to 32-bit Transition
- [ ] Understanding Protected Mode
- [ ] Setting up GDT (Global Descriptor Table)
- [ ] Switching from 16-bit Real Mode to 32-bit Protected Mode
- [ ] Writing a 32-bit kernel entry point

## Phase 3: Basic Kernel Development
- [ ] Setting up a C kernel
- [ ] Implementing basic text output (VGA)
- [ ] Keyboard input handling
- [ ] Interrupt handling (IDT)

## Phase 4: Memory Management
- [ ] Understanding paging
- [ ] Implementing a simple memory allocator
- [ ] Virtual memory basics

## Phase 5: Advanced Features
- [ ] Process management
- [ ] Multitasking
- [ ] File system basics
- [ ] System calls

## Key Concepts to Study

### Assembly Programming
- x86/x86-64 instruction set
- Register usage
- Memory addressing modes
- BIOS interrupts

### Boot Process
- BIOS vs UEFI
- MBR (Master Boot Record)
- Boot sector (512 bytes, signature 0xAA55)
- Disk I/O using BIOS interrupts

### Protected Mode
- Segment descriptors
- GDT (Global Descriptor Table)
- Privilege levels (Ring 0-3)
- A20 line enabling

### Kernel Development
- Bare metal programming
- No standard library
- Hardware interaction
- Interrupt handling

## Useful Resources

1. **OSDev Wiki**: https://wiki.osdev.org/
   - Comprehensive resource for OS development
   - Tutorials and reference materials

2. **Writing a Simple Operating System from Scratch** by Nick Blundell
   - Free PDF available online
   - Great starting point

3. **The little book about OS development** by Erik Helin and Adam Renberg
   - Available at https://littleosbook.github.io/

4. **Intel Software Developer Manuals**
   - Official x86 architecture documentation

5. **OSDev Forums**
   - Community support and discussions

## Testing Tools

- **QEMU**: Full system emulator
  - Fast testing without rebooting
  - Debugging support with GDB
  
- **Bochs**: x86 emulator with debugging features
  - Step-by-step execution
  - Register inspection

- **VirtualBox/VMware**: For testing on more realistic hardware

## Development Tips

1. Start simple and build incrementally
2. Test frequently in QEMU
3. Use version control (git) for each working state
4. Read assembly output when writing C code
5. Understand what the hardware expects at each stage
6. Debug with QEMU's monitor console
7. Study existing open-source kernels (Linux, Minix, etc.)

## Next Steps for PeachOS

1. Implement Protected Mode transition
2. Add VGA text mode driver for better output
3. Create a C kernel that can print to screen
4. Implement keyboard input handler
5. Set up interrupt handling (IDT)

## Common Pitfalls

- Forgetting to disable interrupts when switching modes
- Incorrect GDT setup
- Not aligning data structures properly
- Forgetting the boot signature (0xAA55)
- Wrong memory addresses for loading code
- Not clearing BSS section in C code

Good luck with your OS development journey!
