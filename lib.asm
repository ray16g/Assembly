global sum_array
global printstr
global get_input
global is_even
global strlen
global atoi
global srand
global rand

global NL
global NULL
global TRUE
global FALSE

;---------------------------------------------------------------------------
strlen:
;
; Description: Calculate the size of a null-terminated string
; Recieves: EAX: address of the string
; Returns: EAX: the size of the string
; Requires: The string must be null terminated
; Notes: None
; Algo: None
;---------------------------------------------------------------------------

    push    esi         ; preserve esi
    
    mov     esi, eax    ; set ESI to the address of the string
    and     eax,0       ; eax will be the counter of non-null characters

    .while:
    
    cmp     byte [esi], NULL

    je      .wend

    inc     esi
    inc     eax

    jmp     .while
    

    .wend:

    pop     esi

    ret
    
; End strlen-------------------------------------------------------------

;---------------------------------------------------------------------------
sum_array:
;
; Description: sums the elements in an array
; Recieves: EAX: address of array
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
; Returns: nothing
; Requires: none
; Notes: issues a syscall to print the string to console
; Algo: none 
;---------------------------------------------------------------------------

    push    eax

    mov     ecx, eax        ; string
    call    strlen
    mov     edx, eax        ; length of string
    mov     eax, 4          ; stdout
    mov     ebx, 1
    int     0x80            ; int

    pop     eax
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

    mov     ecx, eax        ; buffer
    mov     edx, ebx        ; length of buffer
    mov     eax, 3          ; stdin
    mov     ebx, 0
    int     0x80            ; int

    ; eax is set to number of chars + newline character

    ret
; End get_input-------------------------------------------------------------


;---------------------------------------------------------------------------
is_even:
; Description: Takes a value and returns 1 if even or 0 if false
; Recieves: EAX: the unsigned value to check
; Returns: EAX 1 if even, 0 if odd
; Requires: none
; Notes: none
; Algo: Flips the bits and returns the first bit (1 is even, 0 is odd) 
;---------------------------------------------------------------------------

    not     eax
    and     eax, 1

    ret
    
; End is_even-------------------------------------------------------------

;---------------------------------------------------------------------------
atoi:
;
; Description: Converts binary string representation to unsigned integer (stops at null terminated string)
; Recieves: EAX: binary in string
; Returns:  EAX: binary in integer
; Requires:
; Notes:
; Algo:
;---------------------------------------------------------------------------

    push    esi
    push    ebx         

    mov     esi, eax    ; set ESI to the address of the string
    and     eax,0       ; eax will be binary in unsigned integer

    .while:
    
    cmp     byte [esi], NULL    ; checks if current character is null 

    je      .wend       ; ends while loop if end character is null

    ; below 4 lines is eax = eax * 10
    mov     ebx, eax    ; ebx = eax
    shl     eax, 3      ; eax = eax * pow(2,3) 
    shl     ebx, 1      ; ebx = ebx * 2
    add     eax, ebx    ; eax = eax + ebx
    
    and     ebx, 0      ; set ebx to 0
    
    movzx   ebx, BYTE [esi]  ; set ebx to value of character in string
    sub     ebx , 48    ; ebx = ebx - 48

    add     eax, ebx    ; eax = eax - ebx 

    inc     esi         ; next character in string

    jmp     .while
    
    .wend:

    pop     ebx
    pop     esi
    ret
    
; End procedure-------------------------------------------------------------

;---------------------------------------------------------------------------
srand:
;
; Description: sets the seed for rand procedure
; Recieves: EAX = seed
; Returns: none
; Requires: none
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    mov [next], eax

    ret
    
; End srand-------------------------------------------------------------

;---------------------------------------------------------------------------
rand:
;
; Description: sets a random value based on seed into eax
; Recieves: none
; Returns: eax as random value
; Requires: none 
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    push    edx         ; preserve edx
    push    ebx         ; preserve ebx

    mov     eax, [next] ; eax = next

    mov     ebx, ran1
    mul     ebx         ; eax = eax * 1103515245 

    mov     ebx, ran2
    add     eax, ebx    ; eax = eax + 12345

    mov     [next], eax ; next = eax

    mov     ebx, ran3

    xor     edx, edx    ; 0 edx
    div     ebx         ; eax = eax / 65536 

    mov     ebx, ran4

    xor     edx, edx    ; 0 edx
    div     ebx         ; edx = eax % 32768 (eax is set to eax / 32768)

    mov     eax, edx    ; eax = edx 
    ; return eax

    pop     ebx         ; preserve ebx
    pop     edx         ; preserve edx

    ret
    
; End procedure-------------------------------------------------------------


NL:     equ 0xa
NULL:   equ 0
TRUE:   equ 1
FALSE:  equ 0

section .bss
next: resd 1

section .data
ran1: equ 1103515245 
ran2: equ 12345
ran3: equ 65536
ran4: equ 32768
