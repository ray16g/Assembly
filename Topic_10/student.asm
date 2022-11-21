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

section     .text

global      _start

_start:
    push    numPrompt       
    call    printstr        ; print prompt for # of students
    add     esp, 4

    push    dword buffersz
    push    buffer
    call    get_input       ; get input for # of students
    add     esp, 8

    push    buffer
    call    atoi            ; convert input to string
    add     esp, 4

    mov     esi, students   ; set esi as students
    mov     ecx, 0          ; set counter to 0
    mov     ebx, eax        ; set ebx to # of students

    .while:
    cmp     ecx, ebx        ; if counter == # of students
    jge    .endwhile        ; jump if above is false
    
    push    ecx             ; preserve ecx

    push    infoPrompt
    call    printstr        ; Print new student prompt
    add     esp, 4

    push    idPrompt
    call    printstr        ; print ID prompt
    add     esp, 4

    lea     edi, [esi + student.id]
    push    dword 10
    push    edi
    call    get_input       ; store input into student.id structure
    add     esp, 8
    
    push    namePrompt 
    call    printstr        ; print name prompt
    add     esp, 4
    
    lea     edi, [esi + student.name]
    push    dword 150
    push    edi
    call    get_input       ; store input into student.name structure
    add     esp, 8

    push    gradePrompt
    call    printstr        ; print grade prompt
    add     esp, 4

    lea     edi, [esi + student.grade]
    push    dword 1
    push    edi
    call    get_char_input  ; store input into student.grade structure
    add     esp, 8

    pop     ecx             ; restore ecx

    add     esi, student_size   ; go to the next structure
    inc     ecx                 ; increase counter
    jmp     .while
    .endwhile:

    mov     esi, students       ; set esi back to students
    mov     edi, 0              ; clear edi
    mov     ecx, ebx            ; set counter to # of students
    mov     eax, 0              ; clear eax
    .loop:
    push    ecx                 ; preserve ecx
    push    eax                 ; preserve eax

    lea     edi, [esi + student.name]
    push    edi
    call    printstr            ; print student name
    add     esp, 4

    push    outputString1  
    call    printstr            ; print output
    add     esp,4

    lea     edi, [esi + student.id]
    push    edi
    call    printstr            ; print student id
    add     esp, 4

    push    outputString2
    call    printstr            ; print output2
    add     esp, 4

    lea     edi, [esi + student.grade]
    push    edi
    call    printchar           ; print student grade
    add     esp, 4
    
    call    print_newline       ; new line

    add     esi, student_size   ; go to next structure

    pop     eax                 ; restore ecx

    push    ebx                 ; preserve ebx
    mov     ebx, 0
    mov     bl, [edi]          ; set ebx to student.grade character
    add     eax, ebx              ; eax = eax + ebx (grade character in integer)
    pop     ebx                 ; restore ebx

    pop     ecx                 ; restore ecx
    loop    .loop

    push    eax                 ; preserve eax
    push    outputString3       ; print outputstring3
    call    printstr
    add     esp,4 
    pop     eax                 ; restore eax
        
    mov     edx,0               ; clear edx for division
    div     ebx                 ; divide eax (total of grades) by ebx (# of students)

    push    eax                 ; put eax to the stack
    push    esp                 ; push the pointer to eax (character in integers) into the stack
    call    printchar           ; print character of eax
    add     esp, 8

    call    print_newline       

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

outputString1: db "'s ID is ",0
outputString2: db " and has a grade of ",0
outputString3: db "The average grade is ",0