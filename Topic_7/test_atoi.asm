; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: information
; why: file.asm
; when: 19/10/2022 (DD/MM/YYYY)


section     .text

global      _start

extern      atoi
extern      get_input
extern      printstr

_start:
    mov     eax, prompt
    call    printstr

    mov     eax, buffer
    mov     ebx, buffersz
    call    get_input

    mov     eax, buffer
    call    atoi

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss
buffersz    equ 100
buffer:     resb buffersz

section     .data

string:     db  "1024", 0
prompt:     db  "Enter integer: ",0