#include <stdint.h>

// Minimal Multiboot header (v1), placed in a special section
// so GRUB can recognize this ELF as a Multiboot kernel.

#define MULTIBOOT_MAGIC     0x1BADB002
#define MULTIBOOT_FLAGS     0x00000000
#define MULTIBOOT_CHECKSUM  (-(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS))

__attribute__((section(".multiboot")))
const uint32_t multiboot_header[] = {
    MULTIBOOT_MAGIC,
    MULTIBOOT_FLAGS,
    MULTIBOOT_CHECKSUM
};

static volatile char *const VGA_TEXT_BUFFER = (volatile char *)0xB8000;

static void kputc_at(int col, int row, char c, uint8_t attr)
{
    const int index = (row * 80 + col) * 2;
    VGA_TEXT_BUFFER[index]     = c;
    VGA_TEXT_BUFFER[index + 1] = attr;
}

static void kprint(const char *s)
{
    int col = 0;
    int row = 0;
    while (*s) {
        if (*s == '\n') {
            row++;
            col = 0;
        } else {
            kputc_at(col, row, *s, 0x0F);
            col++;
        }
        s++;
    }
}

void kernel_main(void)
{
    // Clear the screen
    for (int row = 0; row < 25; row++) {
        for (int col = 0; col < 80; col++) {
            kputc_at(col, row, ' ', 0x0F);
        }
    }
    kprint("Hello from Multiboot C kernel!\n");

    for (;;) {
        __asm__ volatile ("hlt");
    }
}

// GRUB will jump to the ELF entry point (_start). We keep it in C
// and just forward to kernel_main.
void _start(void)
{
    kernel_main();
    for (;;) {
        __asm__ volatile ("hlt");
    }
}
