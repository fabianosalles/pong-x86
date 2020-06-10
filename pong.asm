;
; Pong for 8086 processor using fasm syntax
; Fabiano Salles <fabiano.salles@gmail.com>
; ------------------------------------------------------------
; This program run in VGA mode 13h using direct VGA addressing
; ------------------------------------------------------------
; Use W and A to move player 1.
; Use Up and down keys to move player 2.
;

use16 						; 16bit bin (dos COM)
org	0x0100

; -------------------------------------------------------
;  DEFINES AND CONSTANTS
; -------------------------------------------------------
	VGA_BASE				= 0xA000
	VGA_SEGMENT				equ gs
	VGA_WORDS_COUNT			= 0x7D00  ; number of words in display memory (320 * 200 / 2) 	
	MAXX					= 320-1
	MAXY					= 200-1
	
	VK_SCAPE				= 01h
	VK_W                 	= 11h
	VK_S                 	= 1Fh
	VK_UP					= 48h	
	VK_DOWN					= 50h	
	VK_LEFT					= 4Bh
	VK_RIGHT				= 4Dh
	
	jmp start

; -------------------------------------------------------
;  CODE
; -------------------------------------------------------
start:
   cli 							; disable interrupts 
   mov	ax, cs           		; code,data,stack share same segment 
   mov	ds, ax 
   mov	ss, ax 
   xor	sp, sp 
 
   mov	ax, VGA_BASE      		; Video memory segment 
   mov	VGA_SEGMENT, ax 		; will be in gs 
   sti							; we'e done so, reenable interrupts

