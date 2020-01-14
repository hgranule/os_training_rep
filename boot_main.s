[org 0x7c00] ; bootloader offset
	mov bp, 0x9000 ; set the stack
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_cstr_16
	call print_nl_16

	call switch_to_pm
	jmp $ ; NEVER GET IT

%include "print_16bit.s"
%include "gdt.s"
%include "print_32bit.s"
%include "switch.s"

[bits 32]
BEGIN_PM:
	mov ebx, MSG_PROT_MODE
	call print_cstr_32
	jmp $

MSG_REAL_MODE db 'Loaded 16-bit mode', 0x0
MSG_PROT_MODE db 'Loaded 32-bit mode', 0x0

; bootsector
times 510-($-$$) db 0
dw 0xaa55