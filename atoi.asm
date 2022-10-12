; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: information
; why: file.asm
; when: 00/00/2022 (DD/MM/YYYY)


section     .text

global      _start

extern      atoi

_start:

    mov eax, string
    call    atoi

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data

string: db  "10001010101", 0