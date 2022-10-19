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

section     .text

global      _start

_start:
    mov     eax, 1234h
    mov     ebx, 100h
    mul     ebx
_mul:
    mov     eax, 0ffff8760h
    mov     ebx, 100h
    imul    ebx
_imul:
    mov     ah, 0
    mov     al, 9
    mov     bl, 2
    div     bl
_div:
    mov     ah, 0
    mov     al, 0x80
    cbw
_sextend:

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data