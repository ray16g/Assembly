; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Check if data is parity
; why: parity.asm
; when: 09/10/2022 (DD/MM/YYYY)


section     .text

global      _start

extern printstr

_start:
    mov ebx, 5   ; test case
    cmp ebx, 0
    js label1           ; jump if negative number

    mov eax, positive
    mov ebx, positiveLen   ; print is positive number
    call printstr

    jmp exit

    label1:
    mov eax, negative     ; jump if negative number
    mov ebx, negativeLen
    call printstr

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data
negative:  db "The value in EAX is negative", 0xa
negativeLen: equ $ - negative

positive: db "The value in EBX is not negative", 0xa
positiveLen: equ $ - positive