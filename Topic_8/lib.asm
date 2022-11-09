global sum_array
global printstr
global get_input
global is_even
global strlen
global atoi
global itoa
global srand
global rand
global current_time
global swap
global swap_xor
global sum
global factorial
global print_newline
global copy_int_array
global strcopy
global to_lower
global to_upper

global NL
global NULL
global TRUE
global FALSE
global RAND_MAX

;---------------------------------------------------------------------------
strlen:
;
; Description: Calculate the size of a null-terminated string
; Recieves: address of the stirng on stack (arg1)
; Returns: EAX: the size of the string
; Requires: The string must be null terminated
; Notes: None
; Algo: None
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp
    push    ecx
    push    edi             ; preserve esi
    mov     edi, [ebp + 8]  ; set ESI to the address of the string
    mov     al, 0           ; compare to 0
    mov     ecx, 256        ; counter of 255
    cld                     ; set direction flag

    repne   scasb           ; repeat until find null character
    mov     eax, 256        ; len = 256 - ecx
    sub     eax, ecx

    pop     edi
    pop     ecx
    leave

    ret
    
; End strlen-------------------------------------------------------------

;---------------------------------------------------------------------------
sum_array:
;
; Description: sums the elements in an array
; Recieves: ARG1: address of array
;           ARG2: number of elements
; Returns:  EAX: sum of the elems in the array
; Requires: none
; Notes: none
; Algo: none 
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    push    esi

    mov     esi, [ebp + 8]        ; store array address in esi
    mov     ecx, [ebp + 12]        ; mov length of array to counter
    xor     eax, eax        ; set eax to 0

    .loop1:

    add     eax, [esi]      ; add index at array to total
    add     esi, 4          ; increment

    loop    .loop1          ; loop

    pop      esi

    leave

    ret
    
; End sum_array-------------------------------------------------------------


;---------------------------------------------------------------------------
printstr:
;
; Description: prints string
; Recieves: ARG1: address of the string
; Returns: nothing
; Requires: none
; Notes: issues a syscall to print the string to console
; Algo: none 
;---------------------------------------------------------------------------
    push    ebp
    mov     ebp, esp

    push    eax

    push    dword [ebp + 8]
    call    strlen
    add     esp, 4
    
    mov     ecx, [ebp + 8]
    mov     edx, eax        ; length of string
    mov     eax, 4          ; syswrite
    mov     ebx, 1          ; stdout
    int     0x80            ; int

    pop     eax

    leave

    ret
; End printstr-------------------------------------------------------------

;---------------------------------------------------------------------------
print_newline:
;
; Description: prints newline
; Recieves: nothing
; Returns: nothing
; Requires: none
; Notes: issues a syscall to print the string to console
; Algo: none 
;---------------------------------------------------------------------------
    push    ebp
    mov     ebp, esp

    push    newlinestr
    call    printstr
    add     esp, 4

    leave

    ret
; End printstr-------------------------------------------------------------


;---------------------------------------------------------------------------
get_input:
;
; Description: takes input
; Recieves: ARG1: address of the buffer
;           ARG2: buffer size
; Returns: EAX as number of chars
; Requires: none
; Notes: issues a syscall to take in input
; Algo: none 
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    push    ebx 
    push    esi

    mov     esi, [ebp + 8]
    mov     ecx, [ebp + 8]        ; buffer
    mov     edx, [ebp + 12]        ; length of buffer
    mov     eax, 3          ; stdin
    mov     ebx, 0
    int     0x80            ; int

    ; eax is set to number of chars + newline character
    cmp     byte [esi + eax - 1], NL

    jnz     .endif
    .if: 
    mov     byte [esi + eax - 1], NULL
    dec     eax
    .endif: 
    pop     esi
    pop     ebx

    leave

    ret
; End get_input-------------------------------------------------------------


;---------------------------------------------------------------------------
is_even:
; Description: Takes a value and returns 1 if even or 0 if false
; Recieves: ARG1: the unsigned value to check
; Returns: EAX 1 if even, 0 if odd
; Requires: none
; Notes: none
; Algo: Flips the bits and returns the first bit (1 is even, 0 is odd) 
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    mov     eax, [ebp + 8]
    not     eax
    and     eax, 1

    leave

    ret
    
; End is_even-------------------------------------------------------------

;---------------------------------------------------------------------------
atoi:
;
; Description: Converts ascii representation of a unsigned integer to an integer
; Recieves: ARG1 = ascii representation of a unsigned integer
; Returns:  ARG2 = integer
; Requires: only integer represented characters in string
; Notes: none
; Algo: horner's method
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    push    esi
    push    ebx         

    mov     esi, [ebp + 8]    ; set ESI to the address of the string
    and     eax,0             ; eax will be binary in unsigned integer

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

    leave

    ret
    
; End procedure-------------------------------------------------------------

;---------------------------------------------------------------------------
itoa:
;
; Description: converts an unsigned integer to a null-terminated string representation
; Recieves: ARG1 = unsigned integer value
;           ARG2 = address of string buffer
;           ARG3 = size of buffer
; Returns: nothing
; Requires: nothing
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    push    ebp                 ; preserve caller's base pointer   
    mov     ebp, esp            ; set base of frame

    push    edi

    sub     esp, 8              ; allocate counter var
    mov     dword [ebp - 4], 0  ; intializing counter to 0 
    mov     dword [ebp - 8], 10 ; divisor 

    mov     edi, [ebp + 12]
    mov     eax, [ebp + 8]

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

    pop     edi

    leave

    ret

; End itoa-------------------------------------------------------------



;---------------------------------------------------------------------------
srand:
;
; Description: Seeds the value used by rand
; Recieves: ARG1 = seed
; Returns: none
; Requires: none
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp

    push    eax
    mov     eax, dword [ebp + 8]

    mov     [next], eax

    pop     eax
    leave

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
; Recieves:  param1: address of the first value (val1)
;           param2: address of the second value (val2)
; Returns: none
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

    mov     edx, ecx
    mov     ecx, dword [ebp - 4]
    
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

;---------------------------------------------------------------------------
sum:
;
; Description: Sum first n counting numbers
; Recieves: stack arg = n
; Returns: EAX = sum
;---------------------------------------------------------------------------

    push    ebp                 ; preserve caller's base pointer
    mov     ebp, esp            ; set base of frame

    mov     eax, [ebp + 8]      ; move n into eax
    cmp     eax, 1              ; if n <= 1; base case
    jle     .base               

    dec     eax                 ; dec n for recursive call
    push    eax                 ; push eax
    call    sum                 ; recursive call
    add     eax, [ebp + 8]      ; n + sum(n-1)

    .base:
    leave

    ret
    
; End sum-------------------------------------------------------------

;---------------------------------------------------------------------------
factorial:
;
; Description: calculates factorial of unsigned integer
; Recieves: recieve on stack the value of n
; Returns: the factorial on eax
; Requires: none
; Notes: none
; Algo: none
;---------------------------------------------------------------------------

 
    push    ebp                 ; preserve caller's base pointer
    mov     ebp, esp            ; set base of frame

    mov     eax, [ebp + 8]      ; move n into eax
    cmp     eax, 1              ; if n <= 1; base case
    jle     .base               

    dec     eax                 ; dec n for recursive call
    push    eax                 ; push eax
    call    factorial            ; recursive call
    mul     dword [ebp + 8]      ; n * fact(n-1)

    .base:
    leave

    ret
    
; End factorial-------------------------------------------------------------

;---------------------------------------------------------------------------
copy_int_array:
;
; Description: copy array of double words from one buffer to another
; Recieves: arg1 src array
;           arg2 dest array
;           arg3 size of source array (size in elements)
; Returns: the factorial on eax
; Requires: none
; Notes: dst buffer is expected to be the correct size
; Algo: none
;---------------------------------------------------------------------------

 
    push    ebp                 ; preserve caller's base pointer
    mov     ebp, esp            ; set base of frame
    push    esi
    push    edi

    mov     esi, [ebp + 8]
    mov     edi, [ebp + 12]
    mov     ecx, [ebp + 16]

    cld

    rep     movsd

    pop     edi
    pop     esi
    leave
    ret
    
; End copy_int_array-------------------------------------------------------------

;---------------------------------------------------------------------------
strcopy:
;
; Description: copies source string into destiniation string
; Recieves: arg1: address of source string
;           arg2: address of destiniation string
; Returns: nothing
; Requires: The string must be null terminated
; Notes: None
; Algo: None
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp
    push    eax
    push    ecx
    push    esi
    push    edi

    push    dword [ebp + 8]
    call    strlen
    mov     ecx, eax
    mov     esi, [ebp + 8] 
    mov     edi, [ebp + 12]
    cld
    rep     movsb

    pop     edi
    pop     esi
    pop     ecx
    pop     eax
    leave

    ret
    
; End strcopy-------------------------------------------------------------

;---------------------------------------------------------------------------
to_lower:
;
; Description: lowers all uppercase characters in a string
; Recieves: arg1: address of source string
; Returns: nothing
; Requires: The string must be null terminated
; Notes: None
; Algo: None
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp
    push    eax
    push    edi
    push    esi
    push    ecx

    push    dword [ebp + 8]
    call    strlen
    mov     ecx, eax
    dec     ecx
    mov     esi, [ebp + 8]
    mov     eax, 0

    cld

    .loop:
    lodsb

    cmp     al, 65
    jl      .endif
    cmp     al, 90
    jg      .endif
    
    or      al, 00100000b 
    mov     edi, esi
    dec     edi
    stosb
    .endif:
    loop    .loop

    pop     ecx
    pop     esi
    pop     edi
    pop     eax
    leave

    ret
; End to_lower-------------------------------------------------------------

;---------------------------------------------------------------------------
to_upper:
;
; Description: uppers all lowercase characters in a string
; Recieves: arg1: address of source string
; Returns: nothing
; Requires: The string must be null terminated
; Notes: None
; Algo: None
;---------------------------------------------------------------------------

    push    ebp
    mov     ebp, esp
    push    eax
    push    edi
    push    esi
    push    ecx

    push    dword [ebp + 8]
    call    strlen
    mov     ecx, eax
    dec     ecx
    mov     esi, [ebp + 8]
    mov     eax, 0

    cld

    .loop:
    lodsb

    cmp     al, 97
    jl      .endif
    cmp     al, 122
    jg      .endif
    
    and      al, 11011111b 
    mov     edi, esi
    dec     edi
    stosb
    .endif:
    loop    .loop

    pop     ecx
    pop     esi
    pop     edi
    pop     eax
    leave

    ret
    
; End to_upper-------------------------------------------------------------


NL:     equ 0xa
NULL:   equ 0
TRUE:   equ 1
FALSE:  equ 0

section .bss

section .data
newlinestr:     db   0x0a,0
next: dd 1
RAND1: equ 1103515245 
RAND2: equ 12345
RAND3: equ 65536
RAND4: equ 32768
RAND_MAX: equ RAND4-1