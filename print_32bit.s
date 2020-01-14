[bits 32] ; using 32-bit protected mode

; const
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_cstr_32:
	pusha
	mov edx, VIDEO_MEMORY

.push_string_pm_loop:
	mov al, [ebx]
	mov ah, WHITE_ON_BLACK

	cmp al, 0 ; check if end of string
	je .push_string_pm_done

	mov [edx], ax; store character and color mode
	add ebx, 1
	add edx, 2

	jmp .push_string_pm_loop

.push_string_pm_done:
	popa
	ret