;
; A simple boot sector program that loops forever
;

loop:			; Define a label, "loop", that will allow
			; us to jump back to it, forever

  jmp loop		; Use a simple CPU instruction that jumps to
			; a new memory address to continue execution

times 510-($-$$) db 0   ; When compiled, our program must fit into 
			; 512 bytes, with the last two bytes being 
			; the magic number.
			; Tell assembly compiler to pad out our
			; program with enough zero bytes (db 0) to
			; bring us to 510th byte
dw 0xaa55		; Last two bytes (one word) from the magic
			; number. So, BIOS knows we are a boot sector.
