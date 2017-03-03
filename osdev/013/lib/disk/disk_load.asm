; load DH sectors to ES:BX from drive DL

disk_load:
  push dx	; Store DX on stack so later we can recall how many sectors were requested to be read.
  
  mov ah, 0x02	; BIOS Read sector function; 0x0e was Teletype text
  mov al, dh	; Read DH sectors
  mov ch, 0x00  ; From Cylinder 0 (CHS Notation: Cylinder, Head, Sector)
  mov dh, 0x00  ; From Head 0
  mov cl, 0x02  ; From second sector (after boot sector)

  int 0x13	; BIOS interrupt

  jc disk_error1 ; Carry register is set if error occurred.

  pop dx	; dl contains address to write into
  cmp dh, al	; if AL (sectors read are stored in AL) != DH (sectors expected)
  jne disk_error2
  ret

disk_error1:
  mov dx, ax
  call print_hex

  mov bx, DISK_ERROR_MSG
  call print_string
  jmp $

disk_error2:
  mov bx, DISK_ERROR_MSG2
  call print_string
  jmp $

; Variables
DISK_ERROR_MSG db "Disk read error 1", 0
DISK_ERROR_MSG2 db "Error 2", 0
