;
; game component
;
; remarks:
;   requires 'vga13.inc'
;   requires 'macro/struct.inc'

; 
; Data types
;
struct Vector
    x  dw 0
    y  dw 0
ends

struct Size
    w dw 0
    h dw 0
ends

struct Ball
    pos     Vector
    size    Size
    color   db ?
ends

struct Player
    pos     Vector
    size    Size
    color   db ?
ends

;
; Game data
;
ball Ball <50,50>, <5,5>, COLOR_WHITE
player Player <0,0>, <5,20>, COLOR_WHITE
cpu Player <0,0>, <5,20>, COLOR_WHITE

init_game:
    call ball_reset
    call player_reset 
    ret

draw_game:
    pusha    
    ; draw middle cross dark line
    vert_line SCREEN_W/2, 0, SCREEN_H, COLOR_DGRAY
    horiz_line 0, SCREEN_H/2, SCREEN_W, COLOR_DGRAY
    
    rect [ball.pos.x], [ball.pos.y], [ball.size.w], [ball.size.w], word [ball.color]    ; ball_draw
    rect [player.pos.x], [player.pos.y], [player.size.w], [player.size.h], word [player.color] ; draw player 1
    rect [cpu.pos.x], [cpu.pos.y], [cpu.size.w], [cpu.size.h], word [cpu.color] ; draw cpu player

    popa
    ret

;
; center ball on stage and reset its color to white
;
ball_reset:
    pusha
    mov [ball.color], COLOR_WHITE
    .center_x:
        mov ax, (SCREEN_W/2)
        mov bx, [ball.size.w]
        shr bx, 1
        sub ax, bx
        mov [ball.pos.x], ax
    .center_y:
        mov ax, (SCREEN_H/2)
        mov bx, [ball.size.h]
        shr bx, 1
        sub ax, bx
        mov [ball.pos.y], ax
    popa
    ret

;
; center players on stage and reset its color
;
player_reset:
    pusha
    mov [player.color], COLOR_WHITE
    mov [player.pos.x], 2
    .center_y:
        mov ax, (SCREEN_H/2)
        mov bx, [player.size.h]
        shr bx, 1
        sub ax, bx
        mov [player.pos.y], ax
    mov [cpu.color], COLOR_WHITE
    mov [cpu.pos.x], (SCREEN_W-7) 
    mov [cpu.pos.y], ax
    popa
    ret