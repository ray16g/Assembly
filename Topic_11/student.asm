; who: Raymond Huang, rhuang45
; what: student.asm
; why: student.asm
; when: 21/11/2022
%include "student_inc.inc"

section     .text

global      _start

_start:
    ; prompt user for student count
    call    get_student_qty

    ; prompt user for each student
    

    ; print students 

    ; print average grade


exit:  
    mov     ebx, 0      ; return 0 status on exit - 'No Errors'
    mov     eax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    int     80h


