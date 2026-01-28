#pragma once
#include <stdint.h>

// Minimal Stivale2-like definitions only for compilation/study.
// For real use, prefer the official stivale2.h from the Limine project.

struct stivale2_tag {
    uint64_t identifier;
    uint64_t next;
};

struct stivale2_header_tag_framebuffer {
    struct stivale2_tag tag;
    uint16_t framebuffer_width;
    uint16_t framebuffer_height;
    uint16_t framebuffer_bpp;
    uint16_t unused;
};

struct stivale2_header {
    uint64_t entry_point;
    uint64_t stack;
    uint64_t flags;
    uint64_t tags;
};

struct stivale2_struct {
    uint64_t bootloader_brand;
    uint64_t bootloader_version;
    uint64_t tags;
};

#define STIVALE2_HEADER_TAG_FRAMEBUFFER_ID 0x3ecc1bc43d0f7971
