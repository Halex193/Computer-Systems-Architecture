;200-[3*(c+b-d/a)-300]
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
    b db 10
    c db 100
    d dw 100
    x dw 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV AX, [d]
        DIV byte[a] ; AL = d/a
        MOV BL, [c]
        ADD BL, [b]
        SUB BL, AL ; BL = (c+b-d/a)
        MOV AL, BL
        MOV BL, 3
        MUL BL ; AX = 3*(c+b-d/a)
        SUB AX, 300
        MOV BX, 200
        SUB BX, AX
        MOV [x], BX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
