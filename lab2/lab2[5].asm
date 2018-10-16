;f+(c-2)*(3+a)/(d-4)
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
    a db 0
    c db 5
    d db 7
    f dw 200
    x dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV AL, [c]
        SUB AL, 2
        MOV BL, [a]
        ADD BL, 3
        MUL BL ; AX = (c-2)*(3+a)
        MOV BL, [d]
        SUB BL, 4
        DIV BL ; AL = (c-2)*(3+a)/(d-4)
        MOV AH, 0 ; AX = (c-2)*(3+a)/(d-4)
        ADD AX, [f]
        MOV [x], AX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
