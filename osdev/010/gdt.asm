; GDT: Intel's flat model
gdt_start:

gdt_null:	; The mandatory first segment descriptor is NULL
  dd 0x0	; dd = declare double (word) = 4bytes
  dd 0x0	; We've covered 8 bytes

gdt_code:	; Code Segment Descriptor
  ; base=0x00, limit 0xfffff
  ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001b 0 is for system traps
  ; type flags: (code)1 (conforming)0 (readable) 1 (accessed) 0 -> 1010b
  ; 2nd flags: (granularity) 1 (32-bit default) 1 (64-bit seg) 0 (AVL)0 -> 1100b
  dw 0xffff    	; limit 0xffff First 16 bits
		;Starts from low memory and go higher (also mind little endian nature)
  dw 0x0	; Base (bits 0-15)
  db 0x0	; Base (bits 16-23)
  db 10011010b  ; First flags, type flags (we could have converted them to hex too)
  db 11001111b 	; 2nd Flags, Segment Limit One nibble was remaining
  db 0x0	; Base (bits 24-31)

gdt_data:	; Data Segement
  dw 0xffff
  dw 0x0
  db 0x0
  db 10010010b 	; type flags are (code)0 (expand down)0 (writable)1 (accessed) 0 -> 0010b
  db 11001111b 	; 2nd flags, limit
  db 0x0

gdt_end:	; So that assenber can compute the size of GDT for GDT descriptor

; GDT Descriptor
gdt_descriptor:
  dw gdt_end - gdt_start - 1; Size of our GDT, always less one of true size
  dd gdt_start

; Some handy constants for GDT segment descriptor offsets, which are what segment registers must contain when in
; protected mode.
; For example, when we set DS=0x10 in Protected Mode, CPU knows that we means it to use the segment
; described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our case is the DATA segment. NULL + Code Segment

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
