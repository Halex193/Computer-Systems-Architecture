;(a-b-c)+(a-c-d-d)
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
    a dw 200
    b dw 50
    c dw 50
    d dw 50
    x dw 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV AX, [a] ; AX = a
        SUB AX, [b] ; AX = a - b
        SUB AX, [c] ; AX = (a-b-c)
        
        MOV BX, [a] ; BX = a
        SUB BX, [c] ; BX = a - c
        SUB BX, [d] ; BX = a-c-d
        SUB BX, [d] ; BX = (a-c-d-d)
        
        ADD AX, BX ; AX = (a-b-c)+(a-c-d-d)
        MOV [x], AX ; x = (a-b-c)+(a-c-d-d)
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
