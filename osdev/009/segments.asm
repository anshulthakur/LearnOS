;
; A simple boot sector program that demonstrates segment offsetting
;

mov ah, 0x0e

mov al, [the_secret]
int 0x10		; Does this print 'X'?

mov bx, 0x7c0		; Can't directly access segment registers

			; Why 0x7c0 and not 0x7c00? Because CPU applies the following
			; Formula to compute offsets:
			; real address = [value at segment register * 16] + user specified address offset
			; AND
			; 0x7c0 * 16 = 0x7c00 [Multiplication by 16 shifts left by 1 place, like it does for 2 in binary]
mov ds, bx		; Copy value in bx to ds [data segment register]
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]; Use the general purpose register
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
  db "X"

times 510 - ($-$$) db 0
dw 0xaa55
