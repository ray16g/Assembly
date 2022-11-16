; This is the standard template for CSCI 150 Lab.
; Unless otherwise directed, start your programs with this template file.
; Be sure to rename the file appropriately when used for a lab.
; Also you can/should remove this comment before use. 
; Leave the following comments and replace everything between and including
;  the angle brackets with your information.

; who: Raymond Huang, rhuang45
; what: Student program
; why: student.asm
; when: 16/11/2022 (DD/MM/YYYY)

%include "lib_includes.inc"

struc student
    .id:        resb 10
    .name:      resb 150
    .grade:     resb 1
endstruc

get_quick_input:
    push    ecx
    push    dword buffersz
    push    buffer
    call    get_input
    add     esp, 8
    pop     ecx
    ret


section     .text

global      _start

_start:
    push    numPrompt
    call    printstr
    add     esp, 4

    call    get_quick_input

    push    buffer
    call    atoi
    add     esp, 4

    mov     ecx, 0
    mov     ebx, eax
    mov     esi, students

    .while:
    cmp     ecx, ebx
    jge    .endwhile

    push    ecx

    push    infoPrompt
    call    printstr
    add     esp, 4

    push    idPrompt
    call    printstr
    add     esp, 4

    call    get_quick_input
    add     esi, student.id
    mov     esi, buffer
    sub     esi, student.id

    push    namePrompt
    call    printstr
    add     esp, 4

    call    get_quick_input
    add     esi, student.name
    mov     esi, buffer
    sub     esi, student.name

    push    gradePrompt
    call    printstr
    add     esp, 4

    call    get_quick_input
    add     esi, student.grade
    mov     esi, buffer
    sub     esi, student.grade

    pop     ecx

    inc     ecx
    add     esi, student_size
    jmp     .while
    .endwhile:

    mov     esi, students
    mov     edi, 0
    mov     ecx, ebx
    .loop:

    lea     edi, [esi + student.id]
    
    lea     edi, [esi + student.name]
    lea     edi, [esi + student.grade]

    loop .loop


exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

section     .bss

students:   resb (student_size*30)
buffersz:   equ 255
buffer:     resb buffersz

section     .data
numPrompt:  db "Number of students: ",0
infoPrompt: db "Information of new student",0xa,0
idPrompt:   db "ID: ",0
namePrompt: db "Name: ",0
gradePrompt:db "Grade: ",0 