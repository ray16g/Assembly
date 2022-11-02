; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file. 
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Tests the factorial lib function
; why: Lab 8a
; when: 2/11/2022 (DD MM YYYY)

%include "lib_includes.inc"

section     .text

global      _start

_start:

    push    prompt
    call    printstr
    add     esp, 4

    push    buffersz
    push    buffer
    call    get_input
    add     esp, 8

    push    buffer
    call    atoi
    add     esp, 4

    push    eax
    call    factorial
    add     esp, 4

    push    buffersz
    push    buffer
    push    eax
    call    itoa
    add     esp, 12

    push    output
    call    printstr
    add     esp,4

    push    buffer
    call    printstr
    add     esp, 4

    push    newline
    call    printstr
    add     esp, 4

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss
buffersz:   equ 255
buffer:     resb buffersz

section     .data
prompt:     db "Enter a value for n: ",0
output:     db "n! = ",0
newline:    db 0xa,0