; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Checks if bits 4,5,6 are set in bl
; why: bit_check.asm
; when: 09/10/2022 (DD/MM/YYYY)

extern printstr

section     .text

global      _start

_start:
    mov     bl, 00010110b   ; test case

    test     bl, 1110000b    ; Set all bits other than 4,5,6 to 0
    ; if 4,5,6 bit are not flipped, then bl will be 0

    jz label1   ; no bits are flipped

    ;print
    mov eax, isSet
    mov ebx, isSetLen
    call printstr

    jmp exit    ; jump to exit

    label1:

    ;print
    mov eax, isNotSet
    mov ebx, isNotSetLen
    call printstr


exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

section     .data
isSet:  db "Bits 4, 5, or 6 are set.", 0xa
isSetLen: equ $ - isSet

isNotSet: db "Bits 4, 5, and 6 are not set.", 0xa
isNotSetLen: equ $ - isNotSet