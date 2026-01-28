# PeachOS Makefile

# Tools
ASM = nasm
CC = gcc
LD = ld

# Flags
ASMFLAGS = -f bin
CFLAGS = -m32 -ffreestanding -nostdlib -nostdinc -fno-pie -fno-stack-protector
# LDFLAGS for future use when adding C code
# LDFLAGS = -m elf_i386 -T linker.ld

# Directories
BUILD_DIR = build
BIN_DIR = bin
BOOT_DIR = src/boot
KERNEL_DIR = src/kernel

# Output files
BOOTLOADER = $(BUILD_DIR)/boot.bin
KERNEL = $(BUILD_DIR)/kernel.bin
OS_IMAGE = $(BIN_DIR)/peachos.bin

# Targets
all: $(OS_IMAGE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BOOTLOADER): $(BOOT_DIR)/boot.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

$(KERNEL): $(KERNEL_DIR)/kernel.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

$(OS_IMAGE): $(BOOTLOADER) $(KERNEL) | $(BIN_DIR)
	cat $(BOOTLOADER) $(KERNEL) > $@

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

run: $(OS_IMAGE)
	qemu-system-i386 -drive format=raw,file=$(OS_IMAGE)

.PHONY: all clean run
