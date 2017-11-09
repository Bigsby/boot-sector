[org 0x7c00]                    ; Tell the assembler where this code will be loaded

mov bx, WELCOME_MESSAGE
call print_string

mov dx, 0x1fb6              ; store the value to print in dx 
call print_hex              ; call the function

mov bx, HEX_OUT             ; print the string pointed to 
call print_string           ; by BX ret
; prints the value of DX as hex. 


; TODO: manipulate chars at HEX_OUT to reflect DX

jmp $                           ; Hang

%include "print_string.asm"

print_hex: 
    pusha

    mov si, HEX_OUT+2         ; si points to the target buffer
    mov ax, dx              ; ax contains the number we want to convert
    mov bx, ax          ; store a copy in bx
    xor dx, dx          ; dx will contain the result
    mov cx, 2           ; cx's our counter

    convert_loop:
        mov ax, bx          ; load the number into ax
        and ax, 0fh         ; we want the first 4 bits
        cmp ax, 9h          ; check what we should add
        ja  greater_than_9
        add ax, 30h         ; 0x30 ('0')
        jmp converted

    greater_than_9:
        add ax, 61h         ; or 0x61 ('a')

    converted:
        xchg    al, ah      ; put a null terminator after it
        mov [si], ax        ; (will be overwritten unless this
        inc si              ; is the last one)

        shr bx, 4           ; get the next part
        dec cx              ; one less to do
        jnz convert_loop

        sub di, 4           ; di still points to the target buffer

    popa
    ret

; global variables 
HEX_OUT:
    db "0x0000", 0

WELCOME_MESSAGE:
    db "Welcome to converting", 0

; Padding and magic number. 
times 510-($-$$) db 0 
dw 0xaa55


; 1fb6
; 0001 1111 1011 0110

; 00110001 1 0001
; 01100110 f 1111
; 01100010 b 1011
; 00110110 6 0110

; character ; byte value ; wanted character
; 1     >       0001    >       0011 0001
; f     >       1111    >       0110 0110
; b     >       1011    >       0110 0010
; 6     >       0110    >       0011 0110

; https://stackoverflow.com/questions/8194141/how-to-print-a-number-in-assembly-nasm



;     mov si, ???         ; si points to the target buffer
;     mov ax, 0a31fh      ; ax contains the number we want to convert
;     mov bx, ax          ; store a copy in bx
;     xor dx, dx          ; dx will contain the result
;     mov cx, 3           ; cx's our counter

; convert_loop:
;     mov ax, bx          ; load the number into ax
;     and ax, 0fh         ; we want the first 4 bits
;     cmp ax, 9h          ; check what we should add
;     ja  greater_than_9
;     add ax, 30h         ; 0x30 ('0')
;     jmp converted

; greater_than_9:
;     add ax, 61h         ; or 0x61 ('a')

; converted:
;     xchg    al, ah      ; put a null terminator after it
;     mov [si], ax        ; (will be overwritten unless this
;     inc si              ; is the last one)

;     shr bx, 4           ; get the next part
;     dec cx              ; one less to do
;     jnz convert_loop

;     sub di, 4           ; di still points to the target buffer