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
include 'game.inc'

start:
	cli 					; disable interrupts 
	mov	ax, cs           	; code,data,stack share same segment 
	mov	ds, ax 
	mov	ss, ax 
	xor	sp, sp 
	cld                     ; clear direction flag for string instructions
	mov	ax, VGA_BASE      	; Video memory segment 
	mov	VGA_SEGMENT, ax 	; will be in gs 
	sti						; we'e done so, reenable interrupts
main:
	call init_graphics      			; init VGA mode 13h
	; game main loop 
	.loop:								
		clear_screen COLOR_BLACK
        
		; todo
		; 1. capture input
		; 2. update state
		; 3. draw game
		call draw_game

		call swap_buffers
		jmp main.loop