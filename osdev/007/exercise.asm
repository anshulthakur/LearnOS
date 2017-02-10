; Convert the following logic to assembly
; if(bx <= 4) { mov al, 'A' )
; else if (bx < 40){ mov al, 'B' }
; else { mov al, 'C'}

  mov bx, 30

  cmp bx, 4
  jle move_a
  cmp bx, 40
  jl move_b
  mov al, 'C'
  jmp end

move_a:
  mov al, 'A'
  jmp end

move_b:
  mov al, 'B'
  jmp end

end:
  mov ah, 0x0e
  int 0x10
  
  jmp $
  times 510 - ($-$$) db 0
  dw 0xaa55
