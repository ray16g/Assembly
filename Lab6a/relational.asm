; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Compares ebx and eax and prints relation
; why: relational.asm
; when: 09/10/2022 (DD/MM/YYYY)


section     .text

extern printstr

global      _start


_start:
    mov eax, 5
    mov ebx, 5

    cmp eax, ebx

    ; if zero flag then EAX == EBX
    ; if sign flag then EAX < EBX
    ; if not sign flag then EAX > EBX

    jz equalLabel
    js lessLabel
    jns greaterLabel

    lessLabel:

    ; print less
    mov eax, less
    mov ebx, lessLen
    call printstr

    jmp exit

    greaterLabel:

    ; print greater
    mov eax, greater
    mov ebx, greaterLen
    call printstr

    jmp exit

    equalLabel:

    ;print equal
    mov eax, equal
    mov ebx, equalLen
    call printstr

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data
less: db "EAX<EBX", 0xa
lessLen: equ $ - less

greater: db "EAX>EBX", 0xa
greaterLen: equ $ - greater

equal: db "EAX==EBX", 0xa
equalLen: equ $ - equal