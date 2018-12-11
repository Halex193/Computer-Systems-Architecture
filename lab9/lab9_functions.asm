bits 32

global read_number
global end_file
global open_file
global close_file
global print_numbers

extern fopen, fscanf, fclose, printf, feof
import fopen msvcrt.dll
import fscanf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import feof msvcrt.dll

segment data class=code use32
	file_descriptor dd -1
	access_mode db 'r', 0
	number_format db '%d ', 0
	new_line db 13, 10, 0

segment code class=code use32
	open_file: ; file_name
		MOV EAX, [ESP + 4*1]
		PUSH dword access_mode
		PUSH dword EAX
		CALL [fopen]
		ADD ESP, 4*2
		MOV [file_descriptor], EAX
		RET

	close_file:
		PUSH dword [file_descriptor]
		CALL [fclose]
		ADD ESP, 4*1
		RET

	read_number: ; number
		POP EBX
		PUSH dword number_format
		PUSH dword [file_descriptor]
		CALL [fscanf]
		ADD ESP, 4*2
		PUSH EBX
		RET

	print_numbers: ; numbers, len
		MOV ECX, [ESP + 4*2]
		MOV ESI, [ESP + 4*1]
		CLD
		JECXZ loop_end
		number_loop:
			LODSD
			PUSH ECX
			PUSH ESI
			PUSH dword EAX
			PUSH dword number_format
			CALL [printf]
			ADD ESP, 4*2
			POP ESI
			POP ECX
		LOOP number_loop
		loop_end:

		PUSH dword new_line
		CALL [printf]
		ADD ESP, 4*1

		RET
	end_file:
	   PUSH dword [file_descriptor]
	   CALL [feof]
	   ADD ESP, 4*1
	   RET
