bits 32

global start

extern exit
import exit msvcrt.dll

extern read_number
extern end_file
extern open_file
extern close_file
extern print_numbers

extern fopen, fscanf, fclose, printf, feof
import fopen msvcrt.dll
import fscanf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import feof msvcrt.dll


segment data class=data use32
	file_name db 'numbers.txt', 0
	max_count equ 100
    number resd 1
	P resd max_count
	lenP dd 0
	N resd max_count
	lenN dd 0

segment code class=code use32
	start:
		PUSH dword file_name
		CALL open_file
		ADD ESP, 4*1
        CMP EAX, 0
        JE programEnd

		mainLoop:
			PUSH dword number
			CALL read_number
			ADD ESP, 4*1

			MOV EBX, [number]
			CMP EBX, 0
			JS negativeNumber

				MOV EAX, [lenP]
				MOV [P + EAX * 4], EBX
				INC dword [lenP]
				JMP skip

			negativeNumber:
				MOV EAX, [lenN]
				MOV [N + EAX * 4], EBX
				INC dword [lenN]

			skip:

            CALL end_file
			CMP EAX, 0
		JE mainLoop

		CALL close_file

		PUSH dword [lenP]
		PUSH dword P
		CALL print_numbers
		ADD ESP, 4*2

		PUSH dword [lenN]
		PUSH dword N
		CALL print_numbers
		ADD ESP, 4*2

        programEnd:
		PUSH dword 0
		CALL [exit]
