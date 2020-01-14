[bits 16]
; prints a null terminated string using `int 0xA` wich adress lays at %bx
print_cstr_16:
	pusha

.pstr_loop:
	mov al, [bx]
	cmp al, 0 ; check if it is a null symbol
	je .pstr_loop_end
	mov ah, 0x0e ; bios tty
	int 0x10 ; service 10h
	add bx, 1
	jmp .pstr_loop

.pstr_loop_end:
	popa
	ret

print_nl_16:
	pusha

	mov ah, 0x0e ; bios tty
	mov al, 0xa ; new line char
	int 0x10
	mov al, 0xd ; carriage return char
	int 0x10

	popa
	ret