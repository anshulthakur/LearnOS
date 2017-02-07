[org 0x7c00]

mov ah, 0x0e

mov al, [the_secret]
int 0x10

jmp $ ; Jump to start of this statement: Jump forever

the_secret:
db 'Booting OS' ; Does it work? What does it print?

; Pad with zeros
times 510-($-$$) db 0

dw 0xaa55
