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

extern      sum

global      _start

_start:



exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data

