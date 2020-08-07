;
; system routines
;

macro print text, width{
    ; mov ah, 03h             ; ah = get cursor position and size bios function (results in dx)
    ; int 10h                 ; call the bios function
    mov ax, text
    mov bx, width
    call print_message
}

include '../src/sys.asm'