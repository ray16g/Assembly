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
    mov al, 00110110b   ; test case
    dec al
    jp label1           ; jump if even parity

    mov eax, oddParity
    mov ebx, oddParityLen   ; print is odd parity
    call printstr

    jmp exit

    label1:
    mov eax, evenParity     ; print is even parity
    mov ebx, evenParityLen
    call printstr

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data
evenParity:  db "AL has even parity.", 0xa
evenParityLen: equ $ - evenParity

oddParity: db "AL has odd parity.", 0xa
oddParityLen: equ $ - oddParity