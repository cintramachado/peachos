CC      := i686-elf-gcc
CFLAGS  := -m32 -ffreestanding -O2 -Wall -Wextra
LDFLAGS := -m32 -ffreestanding -nostdlib -T src/linker.ld

BUILD   := build
ISOROOT := iso_root
KERNEL  := $(BUILD)/kernel.elf

LIMINE_BIN_DIR := limine_bin

all: $(KERNEL)

$(BUILD):
	mkdir -p $(BUILD)

$(KERNEL): $(BUILD) src/kernel.c src/stivale2_min.h src/linker.ld
	$(CC) $(CFLAGS) -c src/kernel.c -o $(BUILD)/kernel.o
	$(CC) $(LDFLAGS) $(BUILD)/kernel.o -o $(KERNEL)

iso: all
	mkdir -p $(ISOROOT)/boot/limine
	cp $(KERNEL) $(ISOROOT)/boot/kernel.elf
	cp limine.cfg $(ISOROOT)/
	@echo "[INFO] Agora copie os binarios do Limine (limine.sys, limine-cd.bin, limine-eltorito-efi.bin) para $(ISOROOT)/boot/limine/ manualmente ou ajuste o Makefile se ja tiver um diretorio com eles."

clean:
	rm -rf $(BUILD) $(ISOROOT)

.PHONY: all iso clean
