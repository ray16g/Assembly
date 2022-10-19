; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Finite State Machine, converts string representation of integer to 32 bit signed integer
; why: fsm.asm
; when: 15/10/2022 (DD/MM/YYYY)


section     .text

global      _start

extern      atoi

_start:

    mov     eax, string     ; eax is our value
    mov     ebx, 0          ; boolean value
    cmp     BYTE [eax], '-'     ; check if the first character is a '-'

    jnz     isPos               ; if value is skip the bottom two lines of code

    mov     ebx, 1              ; set boolean value to true (this means the value is negative)
    inc     eax                 ; go to the next character in the string (skip '-')

    isPos: 

    call    atoi            ; atoi procedure call

    cmp     ebx, 1          ; check if our boolean value is true
    jnz     isPos2          ; if the value is not true, skip the bottom lines
    
    neg     eax             ; set eax to negative

    isPos2:

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data

string: db  "-6133", 0