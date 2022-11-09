; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file. 
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang
; what: Delete first element of array
; why: In class exercise
; when: 11/7/2022

%include "lib_includes.inc"

section     .text

global      _start

_start:

    push    array
    call    printstr
    call    print_newline
    add     esp,4

    push    array
    call    strlen
    add     esp, 4

    push    resarray
    push    array
    call    strcopy
    add     esp, 8

    push    resarray
    call    printstr
    call    print_newline
    add     esp,4

    push    array
    call    to_lower
    call    printstr
    call    print_newline
    add     esp, 4

    push    array
    call    to_upper
    call    printstr
    call    print_newline
    add     esp, 4

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss
resarray: resb 8

section     .data
array: db "HELLO World!",0
