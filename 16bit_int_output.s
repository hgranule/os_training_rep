BITS 16

global put_string
; prints a null terminated string using `int 0xA`
; %ax - adress of a string
put_string:
	pusha
	mov bx, ax

.pstr_loop:
	mov al, [bx]
	cmp al, 0
	je .pstr_loop_end
	mov ah, 0x0e
	int 0x10
	add bx, 1
	jmp .pstr_loop

.pstr_loop_end:
	popa
	ret
