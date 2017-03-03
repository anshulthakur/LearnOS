; A boot sector that boots a C-Kernel in 32-bit protected mode

[org 0x7c00]
KERNEL_OFFSET equ 0x1000 	; This is the memory offset to which we will load our kernel.

mov [BOOT_DRIVE], dl		; BIOS stores the boot disk address in dl. Save it somewhere safe.

mov bp, 0x9000			; Set up stack somewhere safe.
mov sp, bp

mov bx, MSG_REAL_MODE		; Announce that we are in real mode.
call print_string

call load_kernel		; Load our kernel image into memory from disk

call switch_to_pm		; Switch to 32 bit protected mode.

jmp $

%include "lib/print/print_string.asm"
%include "lib/disk/disk_load.asm"
%include "lib/pm/gdt.asm"
%include "lib/pm/print_string_pm.asm"
%include "lib/pm/switch_to_pm.asm"
%include "lib/print/print_hex.asm"
[bits 16]

;load Kernel
load_kernel:
  mov bx, MSG_LOAD_KERNEL	; Print Message
  call print_string
  
  mov bx, KERNEL_OFFSET		; Set-up parameters fro our disk_load routine: Load into here
  mov dh, 1			; Read 1 sector (our kernel is under 1 sector)
  mov dl, [BOOT_DRIVE]		; From this place (disk)
  call disk_load
  
  mov bx, MSG_LOADED_KERNEL
  call print_string
  ret

[bits 32]
; Here we are after switching to PM
BEGIN_PM:
  mov ebx, MSG_PROT_MODE	; Print we are in 32-bit mode now.
  call print_string_pm

  call KERNEL_OFFSET		; Move to Kernel code and start executing.

  jmp $

; Global Variables
BOOT_DRIVE	db 0
MSG_REAL_MODE  db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE  db "Successfully landed in 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading Kernel into memory.", 0
MSG_LOADED_KERNEL db "Loaded Kernel into Memory",0

times 510-($-$$) db 0
dw 0xaa55
