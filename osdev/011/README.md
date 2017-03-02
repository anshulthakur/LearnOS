In this section, we start to see how the C compiler creates an underlying assembly language code for us.

_Note_ 

If you are building it on a x86\_64 machine, then `gcc -ffreestanding` will create a 64 bit compiler code. To compile for 32-bit i686 system on this machine, use `gcc -m32 -ffreestanding`.

```
gcc -m32 -ffreestanding -c basic.c -o basic.o
```

Also, it is instructive to see the difference in the dumps for 64bit and 32bit systems:

```
objdump -d basic.o
```

64-bit:

```
basic.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <my_function>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	b8 ba ba 00 00       	mov    $0xbaba,%eax
   9:	5d                   	pop    %rbp
   a:	c3                   	retq 
```

32-Bit:

```
basic.o:     file format elf32-i386


Disassembly of section .text:

00000000 <my_function>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	b8 ba ba 00 00       	mov    $0xbaba,%eax
   8:	5d                   	pop    %ebp
   9:	c3                   	ret    
```

Note the different instructions for stack pointer manipulation.

## Linking:

Again, linking on 64 bit machine to a 32bit code is not 

```
ld -o basic.bin -Ttext 0x0 --oformat binary basic.o
```

Instead, use:

```
ld -melf_i386 -o basic.bin -Ttext 0x0 --oformat binary basic.o
     |                        |           |_ [3]
     |                        |_ [2]
     |_ [1]

[1] Make 32-bit compatible.
[2] Like [org 0x7c00] Instructs compiler/linker to offset label addresses to their absolute addresses.
[3] Have no MetaData in the code (or else CPU will try to execute that too.). Generate raw binary.
```

## Disassembly

Use `ndisasm` to disassemble:

```
ndisasm -b 32 basic.bin
         |_ bits mode (16-bit by default)
```

## Local Variables (`local_var.c`)
Here is the objdump:

```
local_var.o:     file format elf32-i386


Disassembly of section .text:

00000000 <my_function>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
   6:	c7 45 fc ba ba 00 00 	movl   $0xbaba,-0x4(%ebp)
   d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10:	c9                   	leave  
  11:	c3                   	ret    

```

Disassembly of binary:

```
00000000  55                push ebp				; Save stack base pointer (Stack grows down. So, base is bottom)
00000001  89E5              mov ebp,esp				; Move stack base to stack top (stack base is the new stack top)
00000003  83EC10            sub esp,byte +0x10			; Little Endian(MSB at High Memory and LSB at low Memory)[Right to left]
								; Allocate 16 bytes on top of stack
00000006  C745FCBABA0000    mov dword [ebp-0x4],0xbaba		; Move 0xbaba to top of stack pointer 
								; (explicitly as double word 0x0000baba)
0000000D  8B45FC            mov eax,[ebp-0x4]			; Use Effective Address Computation to write value at [ebp -0x4] to eax
								; It cannot be known by programmer beforehand what value is in ebp at
								; Runtime.
00000010  C9                leave				; More efficient implementation of 'mov esp, ebp; pop ebp'
00000011  C3                ret
...
```

## Calling functions

The disassembly looks like (note that mine subtracted 0x18 and not 0x8):

```
00000000  55                push ebp				; Caller Function
00000001  89E5              mov ebp,esp				; Setup Stack Frame
00000003  83EC18            sub esp,byte +0x18			; Allocate space to write 0xdede: subtract and save result in esp
00000006  C70424DEDE0000    mov dword [esp],0xdede		; Write 0xdede into the current address of esp (write high to low)
0000000D  E802000000        call dword 0x14			; Call callee function
00000012  C9                leave				; Restore stack
00000013  C3                ret					; Return from caller
00000014  55                push ebp				; Callee Function
00000015  89E5              mov ebp,esp				; Setup stack pointer: Use 32bit word to save esp
00000017  8B4508            mov eax,[ebp+0x8]			; Skip the 32 bits we just allocated to reach into caller's stack top
								; 0xdede was kept in the allocated 0x18 memory space.
0000001A  5D                pop ebp				; We did no stack manipulation, nothing else to restore
0000001B  C3                ret					; Return from callee

```

For the string function (that introduces pointers):

```
00000000  55                push ebp				; Save stack base pointer
00000001  89E5              mov ebp,esp				; Setup stack top to base
00000003  83EC10            sub esp,byte +0x10			; Allocate address to contain reference to address
00000006  C745FC0F000000    mov dword [ebp-0x4],0xf		; Write address (offset) to stack where we'd find data
								; 0xf is 16 bytes ahead of this line, which skips leave and ret
								; both of which are 8 byte instructions C9 and C3
0000000D  C9                leave				; Restore stack
0000000E  C3                ret					; Return from function
0000000F  48                dec eax				; 48 65 6C 6C 6F 00 is actuall Hello\0. 
00000010  656C              gs insb
00000012  6C                insb
00000013  6F                outsd
00000014  0000              add [eax],al
00000016  0000              add [eax],al
```

This illustrates that what the disassembler sees is not necessarily the assembly code, since it cannot tell whether the value written is a machine code or data. Here, it confused data with machine code and human intelligence must restore meaning to it.

Also, when we pass a reference, it is the address, or address offset from the current line.
