;Useful resource: http://stackoverflow.com/questions/3853730/printing-hexadecimal-digits-with-assembly
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
  
  ; First Letter
  mov ax, dx	; Load value saved in dx into ax
  shr ax, 12	; Shift the value in al by 4 bits and save to address at bx (overall shift by 12 bits in 16 bit register)
  and ax, 0x000F; And MASK
  call CONVERT_TO_HEX
  mov [bx], al  ;
  add bx, 0x0001

  mov ah, 0x0e
  int 0x10   

  ; Second Letter
  mov ax, dx    ; Load value saved in dx into ax
  shr ax, 8    ; overall shift by 8 bits in 16 bit register
  and ax, 0x000F; AND Mask
  call CONVERT_TO_HEX
  mov [bx], al  ;
  add bx, 0x0001

  mov ah, 0x0e
  int 0x10   

  ; Third Letter
  mov ax, dx    ; Load value saved in dx into ax
  shr ax, 4    ; overall shift by 8 bits in 16 bit register
  and ax, 0x000F; AND Mask
  call CONVERT_TO_HEX
  mov [bx], al  ;
  add bx, 0x0001

  mov ah, 0x0e
  int 0x10   

  ; Fourth Letter
  mov ax, dx    ; Load value saved in dx into ax
  and ax, 0x000F; AND Mask
  call CONVERT_TO_HEX
  mov [bx], al  ;

  mov ah, 0x0e
  int 0x10   

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
