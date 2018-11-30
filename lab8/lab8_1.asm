bits 32

global start

extern exit
import exit msvcrt.dll
extern scanf
import scanf msvcrt.dll
extern printf
import printf msvcrt.dll

segment data use32 class=data
    a resd 1
    b resd 1
    format_read db '%d %x', 0
    format_print db '%d', 0
    
segment code use32 class=code
    start:
        PUSH dword b
        PUSH dword a
        PUSH dword format_read
        CALL [scanf]
        ADD ESP, 4*3
        
        MOV EAX, [a]
        ADD EAX, [b]
        MOV ECX, 0
        for_bits:
            SHR EAX, 1
            JNC skip
            INC ECX
            skip:
            CMP EAX, 0
        JNE for_bits
        PUSH ECX
        PUSH dword format_print
        call [printf]
        ADD ESP, 4*2
        
        PUSH dword 0
        CALL [exit]
