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

section     .text

global      _start

_start:
    cld
    mov     ecx, len-1
    lea     esi, [array+4]
    mov     edi, desarray
    rep     movsd
    ; esi = array

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss
desarray: resd 10


section     .data
array: dd 1,1,2,3,4,5,6,7,8,9,10
len: equ $ - array