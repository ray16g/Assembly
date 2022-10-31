global sum

;---------------------------------------------------------------------------
sum:
;
; Description: Sum first n counting numbers
; Recieves: stack arg = n
; Returns: EAX = sum
;---------------------------------------------------------------------------

    push    ebp                 ; preserve caller's base pointer
    mov     ebp, esp            ; set base of frame

    mov     eax, [ebp + 8]      ; move n into eax
    cmp     eax, 1              ; if n <= 1; base case
    jle     .base               

    dec     eax                 ; dec n for recursive call
    push    eax                 ; push eax
    call    sum                 ; recursive call
    add     eax, [ebp + 8]      ; n + sum(n-1)

    .base:
    leave

    ret
    
; End srand-------------------------------------------------------------