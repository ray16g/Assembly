
;---------------------------------------------------------------------------
sum:
;
; Description: Sum first n counting numbers
; Recieves: stack arg = n
; Returns: EAX = sum
;---------------------------------------------------------------------------

    push    ebp                 ; preserve caller's base pointer
    mov     ebp, esp            ; set base of frame

    mov     eax, [ebp + 8]
    cmp     eax, 1
    jle     .base

    dec     eax
    push    eax
    call    sum
    add     eax, [ebp + 8]

    .base:
    leave

    ret
    
; End srand-------------------------------------------------------------