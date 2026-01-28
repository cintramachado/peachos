CC      := ../toolchain/bin/i686-elf-gcc
CFLAGS  := -m32 -ffreestanding -O2 -Wall -Wextra
LDFLAGS := -m32 -ffreestanding -nostdlib -T linker.ld

KERNEL  := kernel.elf
ISO_DIR := iso
GRUB_DIR:= $(ISO_DIR)/boot/grub
ISO_IMG := peachos-multiboot.iso

all: $(KERNEL)

$(KERNEL): kernel.c linker.ld
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o
	$(CC) $(LDFLAGS) kernel.o -o $(KERNEL)

iso: $(KERNEL) grub.cfg
	mkdir -p $(GRUB_DIR)
	cp $(KERNEL) $(ISO_DIR)/boot/kernel.elf
	cp grub.cfg $(GRUB_DIR)/grub.cfg
	grub-mkrescue -o $(ISO_IMG) $(ISO_DIR)

run: iso
	qemu-system-i386 -cdrom $(ISO_IMG)

clean:
	rm -f kernel.o $(KERNEL) $(ISO_IMG)
	rm -rf $(ISO_DIR)

.PHONY: all iso run clean
