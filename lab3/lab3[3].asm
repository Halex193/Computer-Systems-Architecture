;(a+b*c+2/c)/(2+a)+e+x; a,b-byte; c-word; e-doubleword; x-qword - Unsigned representation
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
    a db 98
    b db 100
    c dw 1
    e dd 5
    x dq 8
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV AL, [b]
        MOV AH, 0 ; AX = b
        MUL word [c] ; DX:AX = b * c
        
        MOV BX, AX
        MOV CX, DX ; CX:BX = b * c
        
        MOV DX, 0
        MOV AX, 2 ; DX:AX = 2
        DIV word [c] ; AX = 2 / c
        
        ADD AL, [a]
        ADC AH, 0 ; AX = 2/c + a
        
        ADD BX, AX
        ADC CX, 0 ; CX:BX = (a+b*c+2/c)
        
        MOV AX, BX
        MOV DX, CX ; DX:AX = (a+b*c+2/c)
        
        MOV BL, [a]
        ADD BL, 2
        ADC BH, 0 ; BX = a + 2
        
        DIV BX ; AX = (a+b*c+2/c)/(2+a)
        MOV BX, AX
        MOV EAX, 0
        MOV AX, BX ; EAX = (a+b*c+2/c)/(2+a)
        
        MOV EDX, 0
        ADD EAX, [e]
        ADC EDX, 0 ; EDX:EAX = (a+b*c+2/c)/(2+a)+e
        
        ADD EAX, [x]
        ADC EDX, [x+4] ; EDX:EAX = (a+b*c+2/c)/(2+a)+e+x
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
