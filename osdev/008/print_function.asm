print_function:
  pusha                 ; Save all registers on the stack
  mov ah, 0x0e
  mov al, bl
  int 0x10
  popa                  ; Restore all registers' previous state
  ret                   ; Restore instruction pointer to saved value on stack

