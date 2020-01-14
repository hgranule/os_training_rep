gdt_start:
	; gdt starts with null 8 bytes
	dd 0x0
	dd 0x0

; GDT: code segment
; base=0x0, limit: 0xfffff
; 1 flgs = { (present)1, (privelege)00, (descriptor type)1 -> 1001b }
; type = { (code)1, (conforming)0, (readable)1, (accessed)0 -> 1010b }
; 2 flgs = { (granularity)1, (32bit default)1, (64bit seg)0, (AVL)0 -> 1100b }
gdt_code:
	dw 0xffff		; Limit (0-15 bits)
	dw 0x0			; Base (0-15 bits)
	db 0x0			; Base (16-23 bits)
	db 10011010b	; 1 flgs + type 
	db 11001111b	; 2 flgs + Limit (16-19 bits)
	db 0x0			; Base (24-31 bits)

; GDT: data segment
gdt_data:
	; Same as CODE exept for type
	; type = { (code)0, (expand down)0, (writeable)1, (accessed)0 -> 0010b }
	dw 0xffff		; Limit (0-15 bits)
	dw 0x0			; Base (0-15 bits)
	db 0x0			; Base (16-23 bits)
	db 10010010b	; 1 flgs + type 
	db 11001111b	; 2 flgs + Limit (16-19 bits)
	db 0x0			; Base (24-31 bits)

gdt_end:
	; for calculating

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start