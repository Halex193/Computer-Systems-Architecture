;d - (a + b) - c
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
     a db 50
     b db 50
     c db 50
     d db 150
     x db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV AL, [d] ; Al = d
        MOV BL, [a] ; BL = a
        ADD BL, [b] ; BL = a + b
        SUB AL, BL ; AL = d - (a + b)
        SUB AL, [c] ; AL = d - (a + b) - c
        MOV [x], AL ; x = d - (a + b) - c
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
