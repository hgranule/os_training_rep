[bits 16]
switch_to_pm:
	cli ; disable interuppts
	lgdt [gdt_descriptor] ; load gdt table

	mov eax, cr0
	or eax, 0x1 ; switching cpu to 32bit protected mode by adding bit to %cr0
	mov cr0, eax

	jmp CODE_SEG:init_pm

[bits 32]
init_pm:
	mov ax, DATA_SEG ; update segment registers
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000 ; update the stack right at the top of the free space
    mov esp, ebp

	call BEGIN_PM ; go to the next code
