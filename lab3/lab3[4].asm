;(a+b*c+2/c)/(2+a)+e+x; a,b-byte; c-word; e-doubleword; x-qword - Signed representation
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
        CBW ; AX = b
        IMUL word [c] ; DX:AX = b*c
        
        MOV BX, AX
        MOV CX, DX ; CX:BX = b*c
        
        MOV AX, 2
        CWD ; DX:AX = 2
        IDIV word [c] ; AX = 2/c
        CWD ; DX:AX = 2/c
        
        ADD AL, [a]
        ADC AH, 0
        ADC DX, 0 ; DX:AX = a + 2/c
        
        ADD BX, AX
        ADC DX, CX ; DX:BX = (a+b*c+2/c)
        
        MOV AL, [a]
        CBW ; AX = a
        ADD AX, 2 ; AX = 2 + a
        MOV CX, AX; CX = 2 + a
        MOV AX, BX ; DX:AX = (a+b*c+2/c)
        
        IDIV CX ; AX = (a+b*c+2/c)/(2+a)
        CWDE ; EAX = (a+b*c+2/c)/(2+a)
        CDQ ; EDX:EAX = (a+b*c+2/c)/(2+a)
        ADD EAX, [e]
        ADC EDX, 0 ; EDX:EAX = (a+b*c+2/c)/(2+a)+e
        
        ADD EAX, [x]
        ADC EDX, [x+4] ; EDX:EAX = (a+b*c+2/c)/(2+a)+e+x
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
