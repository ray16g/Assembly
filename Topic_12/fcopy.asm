; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file. 
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang
; what: Copy jpeg 
; why: fcopy.asm
; when: 4/11/2022 (DD MM YYYY)

section     .text

global      _start

_start:

    push    ebp
    mov     ebp, esp
    sub     esp, 8

    mov     eax, 8          ; sys_creat
    mov     ebx, outputFile ; copy
    mov     ecx, 0o777      ; set permissions
    int     0x80            ; syscall
    ; file descriptor is returned on eax

    mov     dword [ebp-4], eax  ; outputFile file descriptr

    mov     eax, 5          ; sys_open
    mov     ebx, inputFile  ; enstein_field_eqs
    mov     ecx, 2          ; read and write access mode
    mov     edx, 0o777      ; syscall
    int     0x80
    ; file descriptor is returned on eax

    mov     dword [ebp-8], eax  ; inputFile file descriptor

    mov     eax, 3          ; sys_read
    mov     ebx, [ebp-8]    ; input file descriptor
    mov     ecx, buffer
    mov     edx, buffersz  
    int     0x80

    mov     eax, 4
    mov     ebx, [ebp-4]    ; output file descriptor
    mov     ecx, buffer
    mov     edx, buffersz
    int     0x80

exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss
buffer:         resb    4096
section     .data
buffersz:       dd 4096
outputFile:     db  "./copy.jpeg",0
inputFile:      db  "./einstein_field_eqs.jpeg",0