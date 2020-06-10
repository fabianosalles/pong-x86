; Hello world 16 bit COM program 
; Fabiano Salles
; https://programmingdrops.com

use16 						; 16bit bin (dos COM)
org	0x0100

vars:
    mesasge db 'Hello world',0
    current_row db 0
    current_col db 0

start:
    mov ah, 13h             ; wirte string bios function
    mov al, 00h             ; parameter write mode
    mov bh, 00h             ; page number
;    mov bl, 0011_1011b     ; text color attribute
    mov cx, 12              ; number of characters in string
    mov dl, 1               ; column to start writing 
    mov dh, 1               ; row to start writing

    push cs
    pop es
    mov bp, vars+1            ; pointer to string to be written     
    int 10h                 ; call bios function
        
    ;    mov ah, 4ch             ; stop current program bios function
    ;    int 21h                 ; call the bios function


;    mov ah, 0Ah
;    mov al, 'x'build
;    mov cx, 05h
;    int 10h

    mov ah, 4ch             ; stop current program bios function
    int 21h                 ; call the bios function

