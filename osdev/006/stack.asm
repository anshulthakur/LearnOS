;
; A simple boot sector program that demonstrates the stack.
;

mov ah, 0x0e ; int 10/ah = 0e hex to indicate teletype mode. al gets character to print

mov bp, 0x8000 ; Set base of stack a little above where BIOS loads the boot sector. 0x7c00 => 1024
mov sp, bp     ; Stack base and stack top are currently at same place

push 'A'       ; Push A on top of stack
push 'B'       ; Another one
push 'C'       ; These are pushed as 16-bit values. So MSB is added by assembler as 0x00

mov al, [0x7ffe]; A is kept at 0x7ffe-0x7fff [and 0x8000 is not being used. That is a boundary?]
int 0x10

mov al, [0x7ffc];
int 0x10;

pop bx         ; Pop can only pop out bytes Pop to bx: Pop from sp to bx
mov al, bl     ; copy lower 8 bits to al
int 0x10

pop bx         ; Pop next
mov al, bl
int 0x10

mov al, [0x7ffe]; fetch value at 0x8000 - 0x0002
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
