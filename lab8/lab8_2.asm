bits 32

global start

extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    file_name db 'words.txt', 0
    access_mode db 'r', 0
    file_descriptor dd -1
    buffer_size equ 100
    word_flag db 1
    space equ ' '
    point equ '.'
    buffer resb buffer_size
    counter dd 0
    format db '%d', 0
    
    
    
segment code use32 class=code
    start:
        PUSH dword access_mode
        PUSH dword file_name
        CALL [fopen]
        ADD ESP, 4*2
        CMP EAX, 0
        JE finish
        MOV [file_descriptor], EAX
        
        file_loop:
            PUSH dword [file_descriptor]
            PUSH dword buffer_size
            PUSH dword 1
            PUSH dword buffer
            CALL [fread]
            ADD ESP, 4*4
            CMP EAX, 0
            JE after
            
            MOV ECX, EAX
            CLD
            MOV ESI, buffer
            buffer_loop:
                LODSB
                CMP AL, space
                JE punctuation
                CMP AL, point
                JE punctuation
                
                CMP byte [word_flag], 1
                JNE skip
                INC dword [counter]
                MOV byte [word_flag], 0
                JMP skip
                
                punctuation:
                MOV byte [word_flag], 1
                
                skip:
            LOOP buffer_loop
        JMP file_loop
        after:
        
        PUSH dword [counter]
        PUSH dword format
        CALL [printf]
        ADD ESP, 4*2
        
        PUSH dword [file_descriptor]
        CALL [fclose]
        ADD ESP, 4
        
        finish:
        PUSH dword 0
        CALL [exit]