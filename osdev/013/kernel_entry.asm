; Ensures that we jump straight to the kernel's entry function.

[bits 32]		; We are in protected mode, using 32 bit instructions
[extern main]		; main is a label that is not present in this asm, but will be there when actually called.

call main
jmp $			; Loop forever
