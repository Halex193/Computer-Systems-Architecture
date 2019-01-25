bits 32

;Read a file name from the console. Read the file's contents and calculate its size in bytes. Append the size to the file's contents
;Example: input.txt: |abcd efgh| => input.txt: |abcd efgh 9|
global start

extern exit, scanf, fread, fwrite, fopen, fclose, fprintf
import exit msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data class=data use32
    fileName times 20 db 0
    accesModeRead db 'r', 0
    accesModeAppend db 'a', 0
    file dd 0
    readFormat db '%s', 0
    contentSize dd 0
    bufferSize equ 200
    buffer times bufferSize db 0
    writeFormat db ' %d', 0
    
segment code class=code use32
	start:
		PUSH dword fileName
        PUSH dword readFormat
        CALL [scanf]
        ADD ESP, 4*2
        
        PUSH dword accesModeRead
        PUSH dword fileName
        CALL [fopen]
        ADD ESP, 4*2
        CMP EAX, 0
        JE .finish
        MOV [file], EAX
		
        MOV dword [contentSize], 0
        .contentLoop:
            PUSH dword [file]
            PUSH dword bufferSize
            PUSH dword 1
            PUSH dword buffer
            CALL [fread]
            ADD ESP, 4*4
            
            CMP EAX, 0
            JE .finishLoop
            ADD dword [contentSize], EAX 
            
        JMP .contentLoop
        .finishLoop:
        
        PUSH dword [file]
        CALL [fclose]
        ADD ESP, 4*1
        
        PUSH dword accesModeAppend
        PUSH dword fileName
        CALL [fopen]
        ADD ESP, 4*2
        CMP EAX, 0
        JE .finish
        MOV [file], EAX
        
        PUSH dword [contentSize]
        PUSH dword writeFormat
        PUSH dword [file]
        CALL [fprintf]
        ADD ESP, 4*3
        
        PUSH dword [file]
        CALL [fclose]
        ADD ESP, 4*1
        .finish:
		PUSH dword 0
		CALL [exit]