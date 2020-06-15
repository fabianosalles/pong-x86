; Hello world 16 bit COM program 
; https://programmingdrops.com

format binary       ; flat binary file format
use16 				; 16bit file
org	0x0100          ; all COM files adresses must be relative to 0x100 memory offset


vars:
    message db 'Hello world!'

start:
    cli                     ; disable interrups
    mov ax, cs
    mov ds, ax              ; code,data and stack share same segment 
    mov ss, ax
    xor sp, sp
    sti                     ; restore interrupts

    mov ah, 03h             ; ah = get cursor position and size bios function (results in dx)
    int 10h                 ; call the bios function

    mov bp, message         ; load the address of "message" in base pointer register
    mov bh, 0               ; page number
    mov cx, 0ch             ; number of chars in the string
    mov bl, 0fh             ; color (white color on black bg)       
    mov ax, 1301h           ; ah = write string function 13h, al = write mode (0: no attributes, 1: use attributes) 
    int 10h                 ; call bios function

    mov ah, 4ch             ; stop current program bios function
    int 21h                 ; call the bios function