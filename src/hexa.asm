[org 0x7c00]                            ; Tell the assembler where this code will be loaded

mov dx, 0x1fb6                          ; store the value to print in dx 
call print_hex                          ; call the function

mov bx, HEX_OUT                         ; print the string pointed to 
call print_string                       ; by BX ret
                                        ; prints the value of DX as hex. 


; TODO: manipulate chars at HEX_OUT to reflect DX

jmp $                           ; Hang

%include "print_string.asm"

print_hex: 
    pusha

    mov si, HEX_OUT+5                   ; si printing pointer starting from the end
    mov bx, dx                          ; store value in bx
    mov cx, 4                           ; start counter to iterate for times for each digit

    print_hex_loop:
        mov ax, bx                      ; move current value to ax
        and ax, 0fh                     ; zero every bit expect the last 4
        cmp ax, 9h                      ; check if it greater that 9, i.e., a letter
        ja print_hex_is_letter
        add ax, 030h                    ; 30h is ASCII '0'
        jmp print_hex_process
    
    print_hex_is_letter:
        add ax, 061h - 0ah                    ; 61h is 'a' - ah the minimum value of ax

    print_hex_process:
        mov [si], al                    ; print current character in si position
        dec si                          ; decrement si to print in the previous position
        shr bx, 4                       ; shift bx to the right 4 bits for the next 4 bits
        dec cx                          ; decrement the counter
        jnz print_hex_loop              ; go to start of loop if counter is not 0

    popa
    ret

; global variables 
HEX_OUT:
    db "0x0000", 0                      ; printing template

; Padding and magic number. 
times 510-($-$$) db 0 
dw 0xaa55