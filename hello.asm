; Hello world 16 bit COM program 
; https://programmingdrops.com

format binary       ; flat binary file format
use16 				; 16bit file
org	0x0100          ; all COM files adresses must be relative to 0x100 memory offset

jmp start

include 'inc/sys.inc'

vars:
    message db 'Hello world!'

start:
    cli                     ; disable interrups
    mov ax, cs
    mov ds, ax              ; code,data and stack share same segment 
    mov ss, ax
    xor sp, sp
    sti                     ; restore interrupts

    print message, 0x0C    

    mov ah, 4ch             ; stop current program bios function
    int 21h                 ; call the bios function