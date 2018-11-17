bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    A db 2, 1, 3, -3
    la EQU ($ - A)
    B db 4, 5, -5, 7
    lb EQU ($ - B)
    R RESB la + lb
    indexR db 0

; our code starts here
segment code use32 class=code
    start:
        MOV EAX, 0
        MOV ECX, la
        JECXZ finish_A
        MOV ESI, 0
        repeat_A:
            MOV AL, [A + ESI]
            CMP AL, 0
            JS skip_A
            TEST AL, 1
            JZ skip_A
            MOV EBX, 0
            MOV BL, [indexR]
            MOV [R + EBX], AL
            INC byte [indexR]
            skip_A:
            INC ESI
        LOOP repeat_A
        finish_A:
        
        MOV ECX, lb
        JECXZ finish_B
        MOV ESI, 0
        repeat_B:
            MOV AL, [B + ESI]
            CMP AL, 0
            JS skip_B
            TEST AL, 1
            JZ skip_B
            MOV EBX, 0
            MOV BL, [indexR]
            MOV [R + EBX], AL
            INC byte [indexR]
            skip_B:
            INC ESI
        LOOP repeat_B
        finish_B:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
