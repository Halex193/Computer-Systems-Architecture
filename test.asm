bits 32

global start

extern exit
import exit msvcrt.dll
extern printf
import printf msvcrt.dll

segment data class=data use32
    a db '0', '1','2','3','4', '5'
    
    format db '%c %c', 0
    
segment code class=code use32
	start:
        
        
        PUSH dword [a + 2]
        PUSH dword [a]
        PUSH word [a]
        PUSH format
        CALL [printf]
        ADD ESP, 4*3
        
		PUSH dword 0
		CALL [exit]