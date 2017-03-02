[bits 32]
; Some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EDX

print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY		; Set edx to the start of vid mem.
  
print_string_pm_loop:
  mov al, [ebx]
  mov ah, WHITE_ON_BLACK	; Note that Video Memory has first byte as character to print
				; And second byte as attributes. But, we are writing inverted
				; Is it because x86 is little endian, but we are writing 
				; individual bytes.
  cmp al, 0
  je print_string_pm_done	; Reached NULL character
  mov [edx], ax			; Write to video memory. Saying [edx] implies write 2 bytes?
  add edx, 2			; Increment 2 bytes into destination
  add ebx, 1			; Increment 1 byte to source

  jmp print_string_pm_loop

print_string_pm_done:		; pm => protected_mode
  popa
  ret
