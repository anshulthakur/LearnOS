print_string:
  pusha
loop:
  mov ax, [bx] ; Note that cmp [bx], 0 does not work. So, we had to move the value into register first and then compare.
  cmp al, 0    ; But this sounds outrageous! Move things into ax to compare, then write ax again to print stuff
	       ; Of course, we could have gone by not doing the mov al, [bx] because we know the lower byte is still there.
  je stop_printing
  mov ah, 0x0e
  mov al, [bx]  
  int 0x10
  add bx, 0x0001
  jmp loop

stop_printing:
  popa
  ret
