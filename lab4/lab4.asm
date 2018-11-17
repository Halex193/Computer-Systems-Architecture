;Given the word A, compute the doubleword B as follows:
;the bits 0-3 of B have the value 0;
;the bits 4-7 of B are the same as the bits 8-11 of A
;the bits 8-9 and 10-11 of B are the invert of the bits 0-1 of A (so 2 times) ;
;the bits 12-15 of B have the value 1
;the bits 16-31 of B are the same as the bits 0-15 of B.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1011100101101010b ; 1011100101011001b
    b dd 0

; our code starts here
segment code use32 class=code
    start:
        MOV EBX, [b] ;the bits 0-3 of B have the value 0;
        
        MOV AX, [a]
        AND AX, 111100000000b
        MOV CL, 4
        SHR AX, CL
        OR BX, AX ; the bits 4-7 of B are the same as the bits 8-11 of A
        
        MOV AX, [a]
        NOT AX
        AND AX, 11b
        MOV CL, 8
        SHL AX, CL
        OR BX, AX ; the bits 8-9 of B are the invert of the bits 0-1 of A
        
        MOV CL, 2
        SHL AX, CL
        OR BX, AX ; the bits 10-11 of B are the invert of the bits 0-1 of A
        
        OR BX, 1111000000000000b ; the bits 12-15 of B have the value 1
        
        MOV EAX, EBX
        MOV CL, 16
        SHL EAX, CL
        OR EBX, EAX ; the bits 16-31 of B are the same as the bits 0-15 of B
        
        MOV [b], EBX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
