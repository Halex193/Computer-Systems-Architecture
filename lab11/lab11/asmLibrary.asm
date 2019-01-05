bits 32

global _read_number
global _end_file
global _open_file
global _close_file
global _print_numbers

extern _fopen, _fscanf, _fclose, _printf, _feof, _file_descriptor

segment data class=code use32
	;file_descriptor dd -1
	access_mode db 'r', 0
	number_format db '%d ', 0
	new_line db 13, 10, 0

segment code class=code use32
	_open_file: ; file_name
		MOV EAX, [ESP + 4*1]
		PUSH dword access_mode
		PUSH dword EAX
		CALL _fopen
		ADD ESP, 4*2
		MOV [_file_descriptor], EAX
		RET

	_close_file:
		PUSH dword [_file_descriptor]
		CALL _fclose
		ADD ESP, 4*1
		RET

	_read_number: ; number
		POP EBX
		PUSH dword number_format
		PUSH dword [_file_descriptor]
		CALL _fscanf
		ADD ESP, 4*2
		PUSH EBX
		RET

	_print_numbers: ; numbers, len
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
			CALL _printf
			ADD ESP, 4*2
			POP ESI
			POP ECX
		LOOP number_loop
		loop_end:

		PUSH dword new_line
		CALL _printf
		ADD ESP, 4*1

		RET
	_end_file:
	   PUSH dword [_file_descriptor]
	   CALL _feof
	   ADD ESP, 4*1
	   RET
