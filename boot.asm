[bits 16]
[org 0x7c00]

start:
    ; Clear screen
    mov ah, 0x00
    mov al, 0x03  ; Text mode 80x25
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

    ; Compare password
    mov si, correct_password
    mov di, input_buffer
    call compare_password
    jz password_correct

    ; Wrong password
    mov si, wrong_password_msg
    call print_string
    jmp $  ; Halt

password_correct:
    mov si, access_granted_msg
    call print_string
    jmp $  ; Halt

; Function to print null-terminated string
print_string:
    mov ah, 0x0E
.next_char:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .next_char
.done:
    ret

; Read password input
read_password:
    mov cx, 0  ; Character counter
.read_char:
    mov ah, 0x00  ; Read character
    int 0x16

    cmp al, 0x0D  ; Enter key
    je .done

    cmp al, 0x08  ; Backspace
    je .backspace

    ; Store character
    mov [di + cx], al
    inc cx

    ; Echo asterisk
    mov ah, 0x0E
    mov al, '*'
    int 0x10

    jmp .read_char

.backspace:
    test cx, cx
    jz .read_char
    dec cx
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 0x08
    int 0x10
    jmp .read_char

.done:
    mov byte [di + cx], 0  ; Null terminate
    ret

; Compare password
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
    cmp al, 0
.equal:
    ret

; Data section
welcome_msg db 'Hello, Welcome to the world in your head!', 0x0D, 0x0A, 0
password_prompt db 'Enter password: ', 0
correct_password db 'secret', 0
wrong_password_msg db 0x0D, 0x0A, 'Access denied!', 0
access_granted_msg db 0x0D, 0x0A, 'Access granted! Welcome.', 0

; Buffer for password input
input_buffer times 16 db 0

; Bootloader signature
times 510 - ($ - $$) db 0
dw 0xAA55
