section .asm

global insb
insb:
    push ebp
    mov ebp, esp

    mov dx, [ebp+8]
    in al, dx
    
    pop ebp
    ret

global insw
insw:
    push ebp
    mov ebp, esp

    mov dx, [ebp+8]
    in ax, dx
    pop ebp
    ret

global outb
outb:
    push ebp
    mov ebp, esp        
    mov dx, [ebp+8]
    mov al, [ebp+12]
    out dx, al
    pop ebp
    ret

global outw
outw:
    push ebp
    mov ebp, esp
    mov dx, [ebp+8]
    mov ax, [ebp+12]
    out dx, ax
    pop ebp
    ret

