bits 32

global start        

extern exit
import exit msvcrt.dll


segment data use32 class=data
    sir DD 12AB5678h, 1256ABCDh, 12344344h
    len EQU ($-sir)/4
    dest RESD len
    destLen DD 0

segment code use32 class=code
    start:
        MOV ECX, len
        MOV ESI, sir
        CLD
        JECXZ finish
        sir_elements_loop:
            MOV EAX, 0
            LODSW ; take the low word
            LODSW ; take the high word in AX
            
            push ECX ; save the counter value to the stack
            MOV ECX, [destLen] ; we compare with all the elements in reverse order
            JECXZ skip
            dest_elements_loop: ; insertion sort
                ; ECX - 1 is the index of the element to be compared with AX
                ; note that multiplication by 4 is required for pointer arithmetic (dest contains doublewords)
                CMP [dest + (ECX - 1) * 4], EAX ; compare the words (high part of the doublewords is 0)
                JB skip ; if it the element is bigger, we don't have to compare anymore
                MOV EBX, [dest + (ECX - 1) * 4]
                MOV [dest + ECX * 4], EBX ; move the element to the right
            LOOP dest_elements_loop
            skip:
            MOV [dest + ECX * 4], EAX; put the doubleword where it belongs (ECX is the index)
            INC dword [destLen] ; an element was added
            pop ECX ; get the counter value back from the stack
        LOOP sir_elements_loop
        
        MOV ECX, len
        MOV ESI, sir
        MOV EDI, 0 ; index for dest string
        sir_elements_loop_2:
            LODSW ; take the low word in AX
            SHL dword [dest + EDI], 8 * 2
            MOV word [dest + EDI], AX ; insert AX as the low part
            LODSW ; take the high word of the sir string
            ADD EDI, 4 ; increment the index with a doubleword
        LOOP sir_elements_loop_2
        
        finish:
        push    dword 0
        call    [exit]
