;
; A boot sector that prints a string using our function
;

[org 0x7c00]

  mov bx, HELLO_MSG  ; use BX as a parameter to our function, so we can specify the address of a string
  call print_string;

  mov bx, GOODBYE_MSG
  call print_string

  jmp $

%include "print_string.asm"

;Data
HELLO_MSG:
  db 'Hello, World!', 0 ; Null terminated

GOODBYE_MSG:
  db 'Goodbye!',0

times 510-($-$$) db 0
dw 0xaa55
