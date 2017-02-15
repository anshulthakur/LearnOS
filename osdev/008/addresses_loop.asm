;Useful resource: http://stackoverflow.com/questions/3853730/printing-hexadecimal-digits-with-assembly

; In this variant, we wish to use a loop to iterate 4 times for printing hex rather than writing stuff 4 times
; We'll use register 'c' to save our iterator variable
[org 0x7c00]

mov dx, 0x1fb6 ; store the value to print in dx

call print_hex ; call the function


jmp $

HEX_OUT: db '0x0000',0

print_hex:
  pusha
  ; TODO: manipulate chars at HEX_OUT to reflect HEX
  ; HINT: Use 'shr' and 'and': Shift right and And operators
  mov bx, HEX_OUT
  add bx, 0x0002 ; Skip '0x' 
  mov cl, 4      ; Want to print 4 bytes
  
LOOP:
  cmp cl, 0
  je END
  mov ax, dx     ; Load value saved in dx into ax
  mov ch, cl     ; Compute how many shifts we want to get to the nibble we are printing
  sub ch, 1
INNER_LOOP:
  cmp ch, 0
  je INNER_LOOP_END
  sub ch, 1
  shr ax, 4  
  jmp INNER_LOOP

INNER_LOOP_END:    
  and ax, 0x000F; And MASK
  call CONVERT_TO_HEX
  mov [bx], al  ;
  add bx, 0x0001
  sub cl, 1      ; Reduce counter by 1 (loop condition)
  jmp LOOP

END:
  mov bx, HEX_OUT
  call print_string
  popa
  ret

%include "exercise/print_string.asm"
 
CONVERT_TO_HEX:   ; Note that this is a kind of inline function 
		  ; and hence must not save the stack using pusha and popa
 		  ; (or else the changes made will not be saved on return)
  cmp al, 9
  jg  ADD_TO_A  ; 10 or more. Use base of 'A'
  add al, '0'   ; else use base '0'
  jmp CONVERSION_DONE
ADD_TO_A:
  sub al, 10
  add al, 'A'
CONVERSION_DONE:
  ret

times 510 - ($-$$) db 0
dw 0xaa55
