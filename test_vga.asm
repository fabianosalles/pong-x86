;
; Simple test program to change to VGA mode 13h 
; https://programmingdrops.com
;

format binary       ; flat binary file format
use16 				; 16bit file
org	0x0100          ; all COM files adresses must be relative to 0x100 memory offset
jmp start

include 'inc/vga13h.inc'

start:
   cli                      ; disable interrups
   mov	ax, cs              ; code,data,stack share same segment 
   mov	ds, ax 
   mov	ss, ax 
   xor	sp, sp      
   cld                      ; clear direction flag for string instructions
   sti                      ; reenable interrupts
   call init_graphics       ; init VGA mode 13h 

main:
    clear_screen COLOR_LDGRAY
    call swap_buffers
    jmp main
