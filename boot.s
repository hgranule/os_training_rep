BITS 16
; Boot sector adress after BIOS loads superblock from HDD
[org 0x7c00]

mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; make stack "empty"

mov ax, my_string
call put_string

jmp $

%include "16bit_int_output.s"

my_string:
	db 'Hello world', 0x0

times 510-($-$$) db 0
dw 0xaa55