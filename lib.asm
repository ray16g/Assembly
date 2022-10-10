global sum_array
global printstr
global get_input
global is_even
global NL
global NULL
global TRUE
global FALSE
;---------------------------------------------------------------------------
sum_array:
;
; Description: sums the elements in an array
; Recieves: EAX: arraddress of array
;           EBX: number of elements
; Returns:  EAX: sum of the elems in the array
; Requires: none
; Notes: none
; Algo: none 
;---------------------------------------------------------------------------

    push    esi

    mov     esi, eax        ; store array address in esi
    mov     ecx, ebx        ; mov length of array to counter
    xor     eax, eax        ; set eax to 0

    .loop1:

    add     eax, [esi]      ; add index at array to total
    add     esi, 4          ; increment

    loop    .loop1          ; loop

    pop      esi
    ret
    
; End sum_array-------------------------------------------------------------


;---------------------------------------------------------------------------
printstr:
;
; Description: prints string
; Recieves: EAX: address of the string
;           EBX: length of the string
; Returns: nothing
; Requires: none
; Notes: issues a syscall to print the string to console
; Algo: none 
;---------------------------------------------------------------------------

    push    esi

    mov     ecx, eax        ; string
    mov     edx, ebx        ; length of string
    mov     eax, 4          ; stdout
    mov     ebx, 1
    int     0x80            ; int

    pop     esi
    ret
; End printstr-------------------------------------------------------------


;---------------------------------------------------------------------------
get_input:
;
; Description: takes input
; Recieves: EAX: address of the buffer
;           EBX: buffer size
; Returns: EAX as number of chars
; Requires: none
; Notes: issues a syscall to take in input
; Algo: none 
;---------------------------------------------------------------------------

    push    esi

    mov     ecx, eax        ; buffer
    mov     edx, ebx        ; length of buffer
    mov     eax, 3          ; stdin
    mov     ebx, 0
    int     0x80            ; int

    ; eax is set to number of chars + newline character

    pop     esi
    ret
; End get_input-------------------------------------------------------------


;---------------------------------------------------------------------------
is_even:
;
; Description: Takes a value and returns 1 if even or 0 if false
; Recieves: EAX: the unsigned value to check
; Returns: EAX 1 if even, 0 if odd
; Requires: none
; Notes: none
; Algo: Flips the bits and returns the first bit (1 is even, 0 is odd) 
;---------------------------------------------------------------------------

    push    esi

    not     eax
    and     eax, 1

    pop     esi
    ret
    
; End is_even-------------------------------------------------------------

NL:     equ 0xa
NULL:   equ 0
TRUE:   equ 1
FALSE:  equ 0
