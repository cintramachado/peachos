#ifndef IO_H
#define IO_H

unsigned char insb(uint16_t port);
unsigned short insw(uint16_t port);

void outb(uint16_t port, unsigned char value);
void outw(uint16_t port, unsigned short value);

#endif