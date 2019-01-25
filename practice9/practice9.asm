bits 32

global start

extern exit, scanf
import exit msvcrt.dll
import scanf msvcrt.dll

segment data class=data use32
    n dd 0
    read_format db '%d', 0
    numbers resb 100
    result resb 100
    ten dw 10
    
segment code class=code use32
	start:
		PUSH dword n
        PUSH dword read_format
        CALL [scanf]
        ADD ESP, 4*2
        MOV ECX, [n]
        JECXZ .finish
        MOV EDI, numbers
        .read_loop:
            PUSH ECX
            PUSH dword EDI
            PUSH dword read_format
            CALL [scanf]
            ADD ESP, 4*2
            ADD EDI, 4
            POP ECX
        LOOP .read_loop
        MOV ESI, numbers
        MOV EDI, result
        CLD
        MOV ECX, [n]
        .number_loop:
            LODSW
            MOV BX, AX
            LODSW
            MOV DX, AX
            MOV AX, BX
            MOV BL, 0
            .divide_loop:
                CMP AX, 0
                JE .out
                DIV word [ten]
                TEST DL, 1
                JNZ .odd
                ADD BL, DL
                .odd:
                MOV DX, 0
            JMP .divide_loop
            .out:
            MOV AL, BL
            STOSB
        LOOP .number_loop
        .finish:
		
		PUSH dword 0
		CALL [exit]