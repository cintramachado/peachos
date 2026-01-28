; Kernel entry point for PeachOS
[BITS 16]
[ORG 0x7e00]

kernel_start:
    ; Switch to protected mode would go here
    ; For now, just display a message
    
    mov si, kernel_msg
    call print_string
    
    ; Halt - infinite loop to handle interrupts
    cli
.halt:
    hlt
    jmp .halt

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10
    jmp print_string
.done:
    ret

kernel_msg: db 'PeachOS Kernel Running!', 13, 10, 0

; Pad to 512 bytes (safe padding that won't go negative)
times 512-($-$$) db 0
