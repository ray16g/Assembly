; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file. 
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: <your name and Mt SAC username goes here>
; what: <the function of this program>
; why: <the name of the lab>
; when: < the due date of this lab.>

extern      swap

section     .text

global      _start

_start:

    mov     eax, array
    mov     ebx, elem_qty
    call    print_unit_array

    call    array_swap

    mov     eax, array
    mov     ebx, elem_qty
    call    print_unit_array

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data

array:      dd 1,2,3,4,5,6,7,8,9
array_sz:   equ $ - array
elem_qty:   equ array_sz / 4


section     .text

array_swap:

    push    ebx                         ; preserve ebx
    push    edi                         ; preserve esi
    push    esi                         ; preserve edi

    mov     esi, array                  ; esi = front iterator
    lea     edi, [array+array_sz-4]     ; edi = back iterator

    .while:
    cmp     esi, edi                    ; check esi < edi
    jae     .wend                       ; if false, exit loop

    mov     eax, esi                    ; move front iterator into eax
    mov     ebx, edi                    ; move back iterator into ebx
    call    swap                        ; swap values at those iterators
    add     esi, 4                      ; increment front iterator
    sub     edi, 4                      ; decrement back iterator 
    jmp     .while                      ; next set of iterators
    .wend:

    pop     esi                         ; restore esi
    pop     edi                         ; restore edi
    pop     ebx                         ; restore ebx 
    
    ret