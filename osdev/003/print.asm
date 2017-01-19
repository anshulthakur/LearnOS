;
; A simple boot sector that prints a message to the screen using a BIOS Routine.
; x86 has 4 GPR named ax, bx, cx and dx - each one word long (16 bits)
; Individual bytes (high and low) can be written addressing as ah, al and likewise.
;

mov ah, 0x0e ; int 10/ah = 0eh -> Scrolling teletype BIO routine.
	     ; setting ah to 0x0e indicates tele-type mode

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $ ; Jump to curent address (i.e. forever).

; taken from NASM Documentation
; $ evaluates to the assembly position at the beginning of the line containing the expression; 
; so you can code an infinite loop using JMP $. 
; $$ evaluates to the beginning of the current section; so you can tell how far into the section you are by using ($-$$).

;
; Padding and magic BIOS number.
;

times 510-($-$$) db 0; Pad the boot sector with zeros
dw 0xaa55 ; Last two bytes form the magic number, so BIOS knows we are boot sector.
