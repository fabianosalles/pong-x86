; Hello world 16 bit COM program 
; Fabiano Salles
; https://programmingdrops.com

format binary       ; flat binary file format
use16 				; 16bit file
org	0x0100


vars:
    message db 'Hello world!'


; -------------------------------------------------------
;  CODE
; -------------------------------------------------------
start:
    cli                     ; disable interrups
    mov ax, cs
    mov ds, ax              ; code,data,stack share same segment 
    mov ss, ax
    xor sp, sp
    sti                     ; restore interrupts

    mov bp, message
    mov bh, 0               ; page number
    mov cx, 0ch              ; number of chars in mdiressages
    mov bl, 0fh             ; color (white color on black bg)     
    mov ah, 13h             ; AH = function number AL=write mode
    mov al, 01h  
    mov dh, 02h              ; DH = row, HL = col
    mov dl, 02h    
    int 10h                 ; INT 10h/AH=13 - write character and attribute at cursor position.

    mov ah, 4ch             ; stop current program bios function
    int 21h                 ; call the bios function

