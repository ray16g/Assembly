; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Checks if bits 4,5,6 are set in bl
; why: bit_check.asm
; when: 09/10/2022 (DD/MM/YYYY)


section     .text

global      _start

extern 

_start:

    

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data