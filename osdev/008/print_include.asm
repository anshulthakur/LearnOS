; This routine shows how to make a function call that also
; Preserves the caller's register state

[org 0x7c00]

; [1] A function put here is encountered in flow. But cannot be called again. Where would it return to?

mov bl, 48  ; ASCII: 0
call print_function	; Call function: Save address of next line from instruction pointer on stack

mov bl, 'H'
call print_function

; [3] Having the function here prints things twice (encountered in flow) And then error. Where to return to?

mov bl, 'A'
call print_function

jmp $

; [4] Having the function here works satisfactorily, even when it is passed a parameter
%include "print_function.asm" ; Gets replaced by contents of file

times 510 - ($-$$) db 0

dw 0xaa55

; [2] Putting the self-contained function here does not print anything
