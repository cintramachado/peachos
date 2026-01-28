#include <stdint.h>
#include "stivale2_min.h"

static uint8_t stack[4096] __attribute__((aligned(16)));

static struct stivale2_header_tag_framebuffer fb_tag = {
    .tag = {
        .identifier = STIVALE2_HEADER_TAG_FRAMEBUFFER_ID,
        .next = 0
    },
    .framebuffer_width  = 0,
    .framebuffer_height = 0,
    .framebuffer_bpp    = 0,
    .unused             = 0
};

__attribute__((section(".stivale2hdr"), used))
static struct stivale2_header stivale2_hdr = {
    .entry_point = 0, // 0 => Limine usa _start como entry
    .stack       = (uint64_t)(stack + sizeof(stack)),
    .flags       = 0,
    .tags        = (uint64_t)&fb_tag
};

void kmain(struct stivale2_struct *info);

void _start(struct stivale2_struct *info) {
    kmain(info);
    for (;;) {
        __asm__ volatile ("hlt");
    }
}

void kmain(struct stivale2_struct *info) {
    (void)info;

    volatile char *video = (char *)0xB8000;
    const char *msg = "Hello from Limine+C";

    for (int i = 0; msg[i]; i++) {
        video[i * 2]     = msg[i];
        video[i * 2 + 1] = 0x0F;
    }

    for (;;) {
        __asm__ volatile ("hlt");
    }
}
