
  mov ah, 0x0e

  mov bp, 0x8000
  mov sp, bp

  push 0
  push 'g'
  push 'n'
  push 'i'
  push 't'
  push 'o'
  push 'o'
  push 'B'
  push ' '
  push 'S'
  push 'O'

  mov al, '"'
  int 0x10
start_print:  		; Loop to print starts here
  ;cmp sp, bp		; Compare if stack pointer is equal to base of stack; Does not work
  ;je stop_print		; if yes, then stop  printing
  pop bx		; else pop element from stack
  cmp bl, 0		; Check if popped element is NULL
  je stop_print		; If yes, then stop printing
  mov al, bl		; Else move character to al and print
  int 0x10
  jmp start_print	; Try for next stack element

stop_print:
  mov al, '"'
  int 0x10
  jmp $

times 510-($-$$) db 0
dw 0xaa55
