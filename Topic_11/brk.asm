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

%include "lib_includes.inc"

section     .text

global      _start

_start:
    mov     eax, 0x2d
    xor     ebx, ebx
    int     0x80

    push    eax
    call    print_unit
    call    print_newline

    mov     eax, 0x2d
    pop     ebx
    add     ebx, 4096
    int     0x80

    push    eax
    call    print_unit
    call    print_newline

    push    dword 0
    call    exit


section     .bss

section     .data

