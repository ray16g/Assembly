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

section     .text

extern      factorial
extern      itoa
extern      atoi
extern      printstr
extern      get_input

global      _start

_start:

    mov     eax, prompt
    call    printstr
    mov     eax, buffer
    mov     ebx, buffersz
    call    get_input

    mov     eax, buffer
    call    atoi

    push    eax
    call    factorial

    mov     ebx, buffer
    mov     ecx, buffersz

    call    itoa

    mov     eax, output
    call    printstr
    mov     eax, buffer
    call    printstr
    mov     eax, newline
    call    printstr

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss
buffersz: equ 255
buffer: resb buffersz

section     .data
prompt: db "Input number to factorial: ",0
output: db "The factorial is ",0
newline: db 0xa,0
