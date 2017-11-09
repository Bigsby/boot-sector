
mov bx, 30

cmp bx, 4               ; comparre with 4
jle less_equal_4        ; jump if less than or equal

cmp bx, 40              ; compare with 40
jl less_40              ; jump if less than

jmp else                ; jump to else if no previous match

less_equal_4:
    mov al, 'A'
    jmp continue

less_40:
    mov al, 'B'
    jmp continue

else:
    mov al, 'C'
    
continue:

mov ah, 0x0e                ; int=10/ah=0x0e -> BIOS tele -type output 
int 0x10                    ; print the character in al


jmp $
; Padding and magic number. 
times 510-($-$$) db 0 
dw 0xaa55