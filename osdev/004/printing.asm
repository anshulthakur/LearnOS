;
; A simple boot sector program that demonstrates addressing.
;
[org 0x7c00]
mov ah, 0x0e ; scrolling tel-type mode BIOS routine

; First attempt
mov al, the_secret
int 0x10

; Second attempt
mov al, [the_secret]
int 0x10

;Third attempt
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

;Fourth attempt
mov al, [0x7c1d]
int 0x10

jmp $ ; Loop forever

the_secret:
  db "X"
;db is "Declare Bytes of data"
; Padding and magic number.

times 510-($-$$) db 0
dw 0xaa55

; First attempt prints gibberish
; Second attempt does not help
; Third attempt works
; 4th doesn't now (if you use offset 0x7c1e)
