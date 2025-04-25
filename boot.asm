[bits 16]
[org 0x7C00]

start:
    ; Clear screen
    mov ah, 0x00
    mov al, 0x03         ; 80x25 text mode
    int 0x10

    ; Set cursor position to top-left (row 0, col 0)
    mov ah, 0x02
    mov bh, 0x00
    mov dh, 0x00
    mov dl, 0x00
    int 0x10

    ; Print welcome message
    mov si, welcome_msg
    call print_string

    ; Prompt for password
    mov si, password_prompt
    call print_string

    ; Password input routine
    mov di, input_buffer
    call read_password

    ; Compare input with correct password
    mov si, correct_password
    mov di, input_buffer
    call compare_password
    jz password_correct

    ; If wrong password
    mov si, wrong_password_msg
    call print_string
    jmp $

password_correct:
    mov si, access_granted_msg
    call print_string
    jmp $  ; Halt or move to next stage later

; ----------------------------
; Function: print_string
; Prints null-terminated string at SI
; ----------------------------
print_string:
    mov ah, 0x0E
.print_next:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .print_next
.done:
    ret

; ----------------------------
; Function: read_password
; Reads password input, stores in DI
; Echoes '*' for each char
; ----------------------------
read_password:
    xor cx, cx  ; Reset char counter
.read_char:
    mov ah, 0x00
    int 0x16

    cmp al, 0x0D      ; Enter key
    je .done

    cmp al, 0x08      ; Backspace
    je .backspace

    ; Store character
    mov [di + cx], al
    inc cx

    ; Echo '*'
    mov ah, 0x0E
    mov al, '*'
    int 0x10

    jmp .read_char

.backspace:
    test cx, cx
    jz .read_char
    dec cx
    mov ah, 0x0E
    mov al, 0x08      ; Move cursor back
    int 0x10
    mov al, ' '       ; Erase '*'
    int 0x10
    mov al, 0x08      ; Move back again
    int 0x10
    jmp .read_char

.done:
    mov byte [di + cx], 0  ; Null-terminate
    ret

; ----------------------------
; Function: compare_password
; Compares strings at SI and DI
; Sets ZF if equal
; ----------------------------
compare_password:
.loop:
    mov al, [si]
    mov bl, [di]
    cmp al, bl
    jne .not_equal
    test al, al
    jz .equal
    inc si
    inc di
    jmp .loop

.not_equal:
    xor ax, ax     ; Clear ZF
    ret

.equal:
    cmp al, al     ; Set ZF
    ret

; ----------------------------
; Data section
; ----------------------------
welcome_msg db 'Hello, Welcome to the world in your head!', 0x0D, 0x0A, 0
password_prompt db 'Enter password: ', 0
correct_password db 'secret', 0
wrong_password_msg db 0x0D, 0x0A, 'Access denied!', 0
access_granted_msg db 0x0D, 0x0A, 'Access granted! Welcome.', 0

input_buffer times 16 db 0

; ----------------------------
; Bootloader signature
; ----------------------------
times 510 - ($ - $$) db 0
dw 0xAA55
