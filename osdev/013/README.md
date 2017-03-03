In this section, we build on section 012 code to make it a bit more robust and allowing multiple functions in the compiled C code without worrying that the compiler will mess up the ordering.

We do so by adding a deterministic assembly function on top of the kernel code.

This assembly file is compiled into an `elf` format and output is an object file `kernel_entry.o`.
Use:

```
nasm kernel_entry.asm -f elf -o kernel_entry.o
```

Then, linking is done using:

```
ld -melf_i386 -o main.bin --oformat binary -Ttext 0x1000 kernel_entry.o main.o
```

Note that the linker respects the ordering of files. So, if `kernel_entry.o` was written before `main.o`, it is put in memory before `main.o`.

Finally, automation of the build process using Makefile is done.
