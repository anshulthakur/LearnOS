[bits 16]
;Switch to protected mode
switch_to_pm:

	cli										; Clear all interrupts and mask them all until enabled again explicitly.
	
	lgdt [gdt_descriptor]	; load our GDT which defines segments for code and data.

	mov eax, cr0					; To make the switch to protected mode, we get first bit of control register
	or eax, 0x01
	mov cr0, eax

	jmp CODE_SEG:init_pm	; Make a far jump (to a new segment) to our 32-bit code. This focres CPU to flush the pipeline

[bits 32]
;Initialize registers and the stack once in PM
init_pm:								; This is begin written in the code segment now.
	mov ax, DATA_SEG
	mov ds, ax						; Data segment is at DATA_SEG
	mov ss, ax						; Stack segment too
	mov es, ax						; General Purpose ES too
	mov fs, ax						; The new ones too.
	mov gs, ax

	mov ebp, 0x90000			; Update our stack position so it is right
	mov esp, ebp

	call BEGIN_PM					; Finally, call some well known label
