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

;
; Game data
;
ball Ball <50,50>,<5,5>,COLOR_WHITE

init_game:
    call ball_reset 
    ret

draw_game:
    pusha
    
    ; draw middle cross dark line
    vert_line SCREEN_W/2, 0, SCREEN_H, COLOR_DGRAY
    horiz_line 0, SCREEN_H/2, SCREEN_W, COLOR_DGRAY
    
    ; call ball_draw
    rect [ball.pos.x], [ball.pos.y], [ball.size.w], [ball.size.w], word [ball.color]

    popa
    ret

ball_draw:
    pusha
    rect ball.pos.x, ball.pos.y, ball.size.w, ball.size.h, ball.color
    popa
    ret

;
; Center ball on stage and reset its color to white
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