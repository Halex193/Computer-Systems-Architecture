;a - byte, b - word, c - double word, d - qword - Unsigned representation
;(d+d)-a-b-c
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 10
    b dw 10
    c dd 10
    d dq 15
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV EAX, dword [d]
        MOV EDX, dword [d + 4] ; EDX:EAX = d
        
        ADD EAX, dword [d]
        ADC EDX, dword [d + 4] ; EDX:EAX = d + d
        
        MOV EBX, 0
        MOV BL, [a]
        SUB EAX, EBX
        SBB EDX, 0 ; EDX:EAX = (d + d) - a
        
        MOV EBX, 0
        MOV BX, [b]
        SUB EAX, EBX
        SBB EDX, 0 ; EDX:EAX = (d + d) - a - b
        
        SUB EAX, [c]
        SBB EDX, 0 ; EDX:EAX = (d + d) - a - b - c
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
