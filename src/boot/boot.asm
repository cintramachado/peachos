; Simple bootloader for PeachOS
; Loads a 512-byte boot sector and transfers control to the kernel

[BITS 16]           ; 16-bit real mode
[ORG 0x7c00]        ; BIOS loads bootloader at 0x7c00

start:
    ; Set up segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    
    ; Print loading message
    mov si, msg_loading
    call print_string
    
    ; Load kernel from disk
    ; Reset disk system
    mov ah, 0x00
    mov dl, 0x80        ; First hard drive
    int 0x13
    
    ; Read sectors from disk
    mov ah, 0x02        ; Read sectors function
    mov al, 1           ; Number of sectors to read
    mov ch, 0           ; Cylinder 0
    mov cl, 2           ; Sector 2 (sector 1 is boot sector)
    mov dh, 0           ; Head 0
    mov dl, 0x80        ; Drive 0
    mov bx, 0x7e00      ; Load kernel at 0x7e00
    int 0x13
    jc disk_error
    
    ; Jump to kernel
    mov si, msg_success
    call print_string
    jmp 0x7e00

disk_error:
    mov si, msg_error
    call print_string
    jmp $

print_string:
    lodsb               ; Load next character
    or al, al           ; Check if zero
    jz .done
    mov ah, 0x0e        ; BIOS teletype function
    int 0x10            ; Print character
    jmp print_string
.done:
    ret

msg_loading: db 'Loading PeachOS...', 13, 10, 0
msg_success: db 'Kernel loaded! Starting...', 13, 10, 0
msg_error: db 'Disk read error!', 13, 10, 0

; Boot signature
times 510-($-$$) db 0
dw 0xaa55
