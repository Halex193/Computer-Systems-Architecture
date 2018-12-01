bits 32

global start        

extern exit
import exit msvcrt.dll


segment data use32 class=data
    sir DD 12AB5678h, 1256ABCDh, 12344344h
    len EQU ($-sir)/4

segment code use32 class=code
    start:
        MOV ECX, len
        MOV ESI, sir
        CLD
        JECXZ finish
        loop_1:
            PUSH dword ECX
            DEC ECX
            JECXZ end_loop
            LODSW
            LODSW
            MOV EDX, ESI
            MOV BX, AX
            loop_2:
                LODSW
                LODSW
                CMP BX, AX
                JNA skip
                MOV [ESI - 2], BX
                MOV [EDX - 2], AX
                MOV BX, AX
                skip:
            LOOP loop_2
            end_loop:
            MOV ESI, EDX
            POP ECX
        LOOP loop_1
        finish:
        PUSH dword 0
        CALL [exit]
