print_string:
    pusha

    mov ah, 0x0e                    ; set scrolling teletype

    start_lopp:

        mov al, [bx]                ; set al to the value in bx address
        
        cmp al, 0                   ; compare the value al address to 0 to test for end of string
        je print_string_return      ; if it is 0, exit
                
        int 0x10                    ; call BIOS interrupt
        
        add bx, word 1              ; move to next bx address
        jmp start_lopp              ; jump to start of loop

    print_string_return:
    mov al, 13                      ; carriage return
    int 0x10
    mov al, 10                      ; new line
    int 0x10

    popa
    ret