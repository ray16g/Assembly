; who: Raymond Huang, rhuang45
; what: student.asm
; why: student.asm
; when: 21/11/2022
%include "student_inc.inc"

section     .text

global      _start

_start:
    push    ebp
    mov     ebp, esp
    sub     esp, 4
    mov     ebx, esp

    ; prompt user for student count
    call    get_student_qty
    cmp     eax, max_student_qty
    jg      exit_with_error

    mov     [ebx], eax
    mov     ecx, [ebx]
    mov     edi, student_array

    .loop:
    push    ecx
    push    edi

    call    get_student
    add     esp, 4

    add     edi, Student_size
    pop     ecx
    loop .loop

    ; print students 
    mov     ecx, [ebx]
    mov     esi, student_array
    .loop2:
    push    ecx
    push    esi
    call    print_student
    add     esp, 4
    
    add     esi, Student_size
    pop     ecx
    loop .loop2
    


    ; print average grade


exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h

exit_with_error:

    push    error_msg
    call    printstr

    mov     ebx, 1
    mov     eax, 1
    int     80h 

section .data
    error_msg:      db "Invalid input!", 0x0a, "Exiting...",0

section .bss
    max_student_qty:    equ 30
    student_array:      resb max_student_qty * Student_size