
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


;---------------------------------------------------------------------------
get_student:
;
; Description:  prompts for and stores a student
; Recieves: arg1: address to store student at
; Returns: nothing
; Requires: student struc
;---------------------------------------------------------------------------

    push    ebp             ; setup frame
    mov     ebp, esp        ; set base of frame 
    
    push    edi             ; preserve edi 
    push    ebx

    mov     ebx, [ebp + 8]
    ; get id
    lea     edi, [ebx + Student.id]
    push    prompt_id
    call    printstr
    push    10
    push    edi
    call    get_input

    ; get name
    lea     edi, [ebx + Student.name]
    push    prompt_name
    call    printstr
    push    150
    push    edi
    call    get_input

    ; get grade
    lea     edi, [ebx + Student.grade]
    push    prompt_grade
    call    printstr
    push    edi
    call    get_char_input
    mov     [edi], al

    pop     ebx
    pop     edi             ; restore edi
    leave                   ; teardown frame
    ret
    
; End get_student-------------------------------------------------------------


;---------------------------------------------------------------------------
print_student:
;
; Description: prints student structure
; Recieves: ARG1: student structure 
; Returns: arg1 to be a student structure
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    push    edi
    push    ebx
    mov     ebx, [ebp + 8]

    push    id
    call    printstr
    lea     edi, [ebx + Student.id]
    push    edi
    call    printstr
    add     esp, 8
    call    print_newline

    push    name
    call    printstr
    lea     edi, [ebx + Student.name]
    push    edi
    call    printstr
    add     esp, 8
    call    print_newline

    push    grade
    call    printstr
    lea     edi, [ebx + Student.grade]
    push    edi
    call    printchar
    add     esp, 8
    call    print_newline

    pop     ebx
    pop     edi
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

    id:                 db "ID: ",0
    name:               db "Name: ",0
    grade:              db "Grade: ",0