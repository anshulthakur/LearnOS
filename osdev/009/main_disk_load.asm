; Read some sectors from the boot disk using our disk_read function

[org 0x7c00]

  mov [BOOT_DRIVE], dl  	; BIOS Stores our boot drive in DL, so it's best to remember this for later

  ;mov dx, [BOOT_DRIVE]		; Is 0x0080
  ;call print_hex

  mov bp, 0x8000		; Setup stack here
  mov sp, bp			

  mov bx, 0x9000		; Load 5 sectors to 0x0000(ES):0x9000(BX)
  mov dh, 2			; 2 sectors must be read (5 is not possible)
  mov dl, [BOOT_DRIVE]
  ;call print_hex		; Prints 0x0580
  call disk_load

  mov dx, [0x9000]
  call print_hex		; We expect it to be 0xdada, stored at 0x9000

  mov dx, [0x9000 + 512] 	; Second loaded sector: should be 0xface
  call print_hex

  jmp $

%include "lib/print_string.asm"
%include "lib/print_hex.asm"
%include "disk_load.asm"

; Global variable
BOOT_DRIVE: db 0

; Bootsector padding:
  times 510 - ($-$$) db 0
  dw 0xaa55

; Add more sectors to verify we are reading them
times 256 dw 0xdada
times 256 dw 0xface
