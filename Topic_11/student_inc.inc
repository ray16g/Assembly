
STRUC   Student
    .id:    resb 10
    .name:  resb 150
    .grade: resb 1
ENDSTRUC

section     .text

%include "lib_includes.inc"

;---------------------------------------------------------------------------
get_student_qty:
;
; Description: get number of students
; Recieves: none 
; Returns: return qty on eax
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    push    dword prompt_stud_qty
    call    printstr
    
    push    dword buff_sz
    push    buff
    call    get_input

    push    buff
    call    atoi

    leave
    ret
    
; End get_student_qty-------------------------------------------------------------


section     .bss
buff_sz:            equ 150
buff:               resb buff_sz

section     .data
prompt_stud_qty:    db "Enter number of students: ",0
prompt_stud:        db "Enter Student",0
prompt_name:        db "Enter name: ",0
prompt_id:          db "Enter ID: ",0
prompt_grade:       db "Enter grade: ",0