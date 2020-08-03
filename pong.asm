;
; Pong for 8086 processor using fasm syntax
; Fabiano Salles <fabiano.salles@gmail.com>
; ------------------------------------------------------------
; This program run in VGA mode 13h using direct VGA addressing
; ------------------------------------------------------------
; Use W and A to move player 1.
; Use Up and down keys to move player 2.
;

format binary       		; flat binary file format
use16 						; 16bit bin (dos COM)
org	0x0100	
jmp start

include 'inc/vga13h.inc'

start:
   cli 						; disable interrupts 
   mov	ax, cs           	; code,data,stack share same segment 
   mov	ds, ax 
   mov	ss, ax 
   xor	sp, sp 
   cld
   mov	ax, VGA_BASE      	; Video memory segment 
   mov	VGA_SEGMENT, ax 	; will be in gs 
   sti						; we'e done so, reenable interrupts
   call init_graphics       ; init VGA mode 13h 
main:
	clear_screen COLOR_DGRAY

	call swap_buffers
	jmp main