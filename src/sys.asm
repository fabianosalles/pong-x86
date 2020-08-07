; Fabiano Salles, 2020
; http://programmingdrops.com

; prints a text to the console using BIOS interrupt
; Input: 
;   AX = text address 
;   BX = text length  
print_message:
    pusha
    push ax
    mov ah, 03h       ; ah = get cursor position and size bios function (results in dx)
    int 10h           ; call the bios function
    pop ax

    mov bp, ax        ; load the address of "message" in base pointer register
    mov bh, 0         ; page number
    mov cx, bx        ; number of chars in the string
    mov bl, 0fh       ; color (white color on black bg)       
    mov ax, 1301h     ; ah = write string function 13h, al = write mode (0: no attributes, 1: use attributes) 
    int 10h           ; call bios function
    popa
    ret
