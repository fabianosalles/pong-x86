;
; VGA mode 13h video driver for COM flat files
; Fabiano Salles, 2020
; http://programmingdrops.com
;


; -------------------------------------------------------
;  DEFINES
; -------------------------------------------------------		

OFFSCREEN_BASE   		equ 0x1000
OFFSCREEN_SEGMENT		equ fs
VGA_BASE				equ 0xA000
VGA_SEGMENT				equ gs
VGA_WORDS_COUNT			equ 0x7D00  ; number of words in display memory (320 * 200 / 2) 	
USE_VSYNC				equ 1		; 0=disabled, 1=enabled 
SCREEN_W			    equ 320
SCREEN_H			    equ 200
MAX_X					equ SCREEN_W-1
MAX_Y					equ SCREEN_H-1

; default color pallete
COLOR_BLACK			equ 0x00
COLOR_BLUE			equ 0x01
COLOR_GREEN			equ 0x02
COLOR_CYAN			equ 0x03
COLOR_RED			equ 0x04
COLOR_MAGENTA		equ 0x05
COLOR_BORWN			equ 0x06
COLOR_LGRAY			equ 0x07	
COLOR_DGRAY		    equ 0x08
COLOR_LBLUE			equ 0x09
COLOR_LGREEN		equ 0x0A
COLOR_LCYAN			equ 0x0B
COLOR_SALMON		equ 0x0C	
COLOR_LMAGENTA		equ 0x0D 
COLOR_YELLOW		equ 0x0E
COLOR_WHITE			equ 0x0F

;
; module data
;
_orig_video_mode db ?    ; orginal video mode 

;
; assuming cs = ds = ss = sp = ax
; 
init_graphics:
   mov ah, 0xf                  ; get current video mode function
   int 0x10
   mov al, [_orig_video_mode]   ; save the current video mode

   add	ax, OFFSCREEN_BASE  	; Offscreen buffer segment 
   mov	OFFSCREEN_SEGMENT, ax   ;
   mov	ax, VGA_BASE      		; Video memory segment 
   mov	VGA_SEGMENT, ax 		; will be in gs
                                ; Setup normal string direction flag (string instructions increment pointers)
   mov  ax, 0x0013 			    ; Enter 320x200 graphics video mode 
   int	0x10      				; invoke BIOS VIDEO service 
   ret

exit_graphics:
    push ax
    mov ah, [_orig_video_mode]   ; gets back to original video mode
    int 0x10
    pop ax        
    ret

;
; clears the offscreen buffer
; reads color parameter from ax
;
clear_back_buffer:
   push ax
   mov  ax, OFFSCREEN_SEGMENT  ; get offscreen buffer segment into ES 
   mov  es, ax 
   xor  di, di     			   ; initial destination offset 
   pop  ax                     ; load bg color from stack into al, ah
   mov  cx, VGA_WORDS_COUNT    ; number of words in display memory (320 * 200 / 2) 
   rep  stosw     			   ; write two pixels each pass 
   ret
	

swap_buffers:
	; Preload registers for fast swap 
	; once vertical reset is detected 
	mov  ax, OFFSCREEN_SEGMENT  
	mov  ds, ax 
	xor  si, si 		
	mov  ax, VGA_SEGMENT
	mov  es, ax 
	xor  di, di 		
	mov  cx, VGA_WORDS_COUNT ; number of words to move (320 * 200 / 2) 	
	 
if USE_VSYNC    ; Wait for vertical reset
	mov  dx, 0x03DA 
    .vend:  
        in   al, dx 
        test al, 0x08 
        jz   swap_buffers.vend 
    .vres:  
        in   al, dx 
        test al, 0x08 
        jnz  swap_buffers.vres 
end if
 
	rep  movsw 	 ; copy offscreen buffer into video memory 
	mov  ax, cs  ; Restore data segment register 
	mov  ds, ax 	
    ret


; -------------------------------------------------------
;  MACROS
; -------------------------------------------------------	
macro clear_screen color{
    mov al, color
    mov ah, color
    call clear_back_buffer
}

macro put_pixel x, y, color{
    mov di, x
    mov bx, y
    mov al, color
    call set_pixel
}
        
macro vert_line x, y, l, color{
    mov		di, x
    mov 	bx, y
    mov 	cx, l
    mov     al, color    
    call 	line_v
}

macro horiz_line x, y, l, color{
    mov 	di, x
    mov 	bx, y
    mov		cx, l
    mov     ax, color
    call	line_h
}


macro rect x, y, w, h, color{
    mov		di, x
    mov		bx, y
    mov		cx, w
    mov    	dx, h
    mov     ax, color
    call	fill_rect
}

include '../src/vga13h.asm'