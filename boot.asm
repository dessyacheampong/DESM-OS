[bits 16]
[org 0x7c00]

start:
    mov ah, 0x0E
    mov al, 'H'
    int 0x10
    mov al, 'i'
    int 0x10
    hlt

times 510 - ($ - $$) db 0
dw 0xAA55
