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
    clear_screen COLOR_LGRAY
    
    ; print some pixels
    put_pixel 10, 10, COLOR_RED
    put_pixel 10, 11, COLOR_RED
    put_pixel 10, 12, COLOR_RED

    ; print an enclosing square line by line
    vert_line 2, 2, SCREEN_H-4, COLOR_BLUE
    vert_line MAX_X-2, 2, SCREEN_H-4, COLOR_BLUE
    horiz_line 3, 2, MAX_X-4, COLOR_CYAN 
    horiz_line 3, MAX_Y-2, MAX_X-4, COLOR_CYAN

    ; print fist 16 pallete shades
    rect 08, 20, 20, 20, 0
    rect 28, 20, 20, 20, 1
    rect 48, 20, 20, 20, 2
    rect 68, 20, 20, 20, 3
    rect 88, 20, 20, 20, 4
    rect 108, 20, 20, 20, 5
    rect 128, 20, 20, 20, 6
    rect 148, 20, 20, 20, 7
    rect 168, 20, 20, 20, 8
    rect 188, 20, 20, 20, 9
    rect 188, 20, 20, 20, 10
    rect 208, 20, 20, 20, 11
    rect 228, 20, 20, 20, 12
    rect 248, 20, 20, 20, 13
    rect 268, 20, 20, 20, 14
    rect 288, 20, 20, 20, 15

    call swap_buffers
    jmp main
