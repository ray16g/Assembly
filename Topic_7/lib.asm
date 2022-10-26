global sum_array
global printstr
global get_input
global is_even
global strlen
global atoi
global srand
global rand
global current_time
global swap
global swap_xor

global NL
global NULL
global TRUE
global FALSE
global RAND_MAX

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
; Description: Converts ascii representation of a unsigned integer to an integer
; Recieves: EAX = ascii representation of a unsigned integer
; Returns:  EAX = integer
; Requires: only integer represented characters in string
; Notes: none
; Algo: horner's method
;---------------------------------------------------------------------------

    push    esi
    push    ebx         

    mov     esi, eax    ; set ESI to the address of the string
    and     eax,0       ; eax will be binary in unsigned integer

    .while:
    cmp     byte [esi], NULL    ; checks if current character is null 
    je      .wend       ; ends while loop if end character is null

    mov     ebx, 10
    mul     ebx         ; eax = eax * 10

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
itoa:
;
; Description: converts an unsigned integer to a null-terminated string representation
; Recieves: EAX = unsigned integer value
;           EBX = address of string buffer
;           ECX = size of buffer
; Returns: nothing
; Requires: nothing
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    push    ebp                 ; preserve caller's base pointer
    push    edi                 
    mov     ebp, esp            ; set base of frame

    sub     esp, 8              ; allocate counter var
    mov     dword [ebp - 4], 0  ; intializing counter to 0 
    mov     dword [ebp - 8], 10 ; divisor 

    mov     edi, ebx

    ; loop eax (until eax == 0)
    ; div by 10
    ; use remainder + 48 as the character 
    .while:
    test    eax, eax 
    jz      .wend
    mov     edx, 0
    div     dword [ebp - 8]

    add     edx, 48
    push    edx
    inc     dword [ebp - 4]
    jmp     .while

    .wend:

    mov     ecx, [ebp - 4]

    .loop:
    pop     eax
    mov     [edi], al
    inc     edi
    loop    .loop
    

    mov     dword [edi], 0

    mov     esp, ebp
    pop     edi
    pop     ebp                 ; restore caller's base pointer
    ret

; End itoa-------------------------------------------------------------



;---------------------------------------------------------------------------
srand:
;
; Description: Seeds the value used by rand
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
; Description: generates a random unsigned integer value using seed
; Recieves: none
; Returns: eax as random value
; Requires: none 
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    push    edx         ; preserve edx
    push    ebx         ; preserve ebx

    ; next = next * 1103515245 + 12345
    mov     eax, [next] ; eax = next
    mov     ebx, RAND1
    mul     ebx         ; eax = eax * 1103515245 
    add     eax, RAND2  ; eax = eax + 12345
    mov     [next], eax ; next = eax

    ; return next/65536 % 32768
    mov     ebx, RAND3
    xor     edx, edx    ; 0 edx
    div     ebx         ; eax = eax / 65536 
    mov     ebx, RAND4
    xor     edx, edx    ; 0 edx
    div     ebx         ; edx = eax % 32768 (eax is set to eax / 32768)
    mov     eax, edx    ; eax = edx 
    ; return eax

    pop     ebx         ; preserve ebx
    pop     edx         ; preserve edx

    ret
    
; End procedure-------------------------------------------------------------

;---------------------------------------------------------------------------
current_time:
;
; Description: Get and return the current time in seconds since Unix Epoch (Jan 1, 1979)
; Recieves: none
; Returns: EAX = integer value for time in escs since the Unix EPOCH
; Requires: none
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    push    ebx         ; preserve

    mov     eax, 13     ; syscall number for time
    mov     ebx, 0      ; time location = NULL 
    int     0x80        ; 32 bit time value returned in eax

    pop     ebx         ; restore

    ret
    
; End srand-------------------------------------------------------------

;---------------------------------------------------------------------------
swap:
;
; Description: Swap 2 values
; Recieves: none
; Returns:  param1: address of the first value (val1)
;           param2: address of the second value (val2)
; Requires: none
; Notes: none
; Algo: none
;---------------------------------------------------------------------------
    push    ebp             ; setup activaiton record
    mov     ebp, esp        
    sub     esp, 4

    mov     ecx, [ebp + 8]      ; load ecx with address of val 1
    mov     ecx, [ecx]          ; load ecx with val1
    mov     edx, [ebp + 12]     ; load edx with address of val2
    mov     edx, [edx]          ; load edx with val 2

    mov     dword [ebp - 4], edx

    xchg    ecx, edx            ; exchange val1 and val2
    
    mov     ebx, [ebp + 8]      ; load ebx with address of val1
    mov     [ebx], ecx          ; update val1 memoery location
    mov     ebx, [ebp + 12]     ; load ebx with address of val2
    mov     [ebx], edx          ; update val2 memory locaiton 

    mov     esp, ebp        ; deallocate local storage
    pop     ebp             ; restore callers base pointer

    ret
    
; End swap-------------------------------------------------------------

;---------------------------------------------------------------------------
swap_xor:
;
; Description: Swap 2 values with xor
; Recieves: none
; Returns:  param1: address of the first value (val1)
;           param2: address of the second value (val2)
; Requires: none
; Notes: none
; Algo: none
;---------------------------------------------------------------------------
    push    ebp             ; setup activaiton record
    mov     ebp, esp        
    
    mov     ecx, [ebp + 8]      ; load ecx with address of val 1
    mov     ecx, [ecx]          ; load ecx with val1
    mov     edx, [ebp + 12]     ; load edx with address of val2
    mov     edx, [edx]          ; load edx with val 2

    cmp     ecx, edx
    jz      end

    xor     ecx, edx
    xor     edx, ecx
    xor     ecx, edx
    
    mov     ebx, [ebp + 8]      ; load ebx with address of val1
    mov     [ebx], ecx          ; update val1 memoery location
    mov     ebx, [ebp + 12]     ; load ebx with address of val2
    mov     [ebx], edx          ; update val2 memory locaiton 

    end:

    mov     esp, ebp        ; deallocate local storage
    pop     ebp             ; restore callers base pointer

    ret
    
; End swap-------------------------------------------------------------


NL:     equ 0xa
NULL:   equ 0
TRUE:   equ 1
FALSE:  equ 0

section .bss

section .data
next: dd 1
RAND1: equ 1103515245 
RAND2: equ 12345
RAND3: equ 65536
RAND4: equ 32768
RAND_MAX: equ RAND4-1