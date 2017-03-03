#Generate final OS binary
all: os-image

clean:
	rm *.bin *.o os-image
	rm -f *.dis

start:
	qemu-system-i386 os-image

os-image: boot_sect.bin kernel.bin 
	cat $^ > $@

boot_sect.bin: boot_sect.asm
	nasm -f bin -o $@ $< -I 'lib/'

#Generate OS Image (without concat to boot sector)
kernel.bin: kernel_entry.o main.o
	ld -o $@ -melf_i386 -Ttext 0x1000 --oformat binary $^

# $@ is LHS argument (file name being generated)
# $^ is all files in same order on RHS
# $< is first file from left on RHS

#Build Main Kernel C routine
main.o: main.c
	gcc -ffreestanding -m32 -c $< -o $@

# Build kernel entry assembly file
kernel_entry.o: kernel_entry.asm
	nasm -f elf -o $@ $<

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
