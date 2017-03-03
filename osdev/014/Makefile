#Automatically expand to a list of existing c files (assuming none is to be excluded from build)
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

#Create a list of object files to build by replacing .c by .o in filenames of C_SOURCES
OBJ = ${C_SOURCES:.c=.o}

#Generate final OS binary
all: os-image

clean:
	rm -fr *.bin *.dis *.o os-image
	rm -fr kernel/*.o boot/*.bin drivers/*.o

start:
	qemu-system-i386 os-image

os-image: boot/boot_sect.bin kernel.bin 
	cat $^ > $@

#Generate OS Image (without concat to boot sector)
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -melf_i386 -Ttext 0x1000 --oformat binary $^

# $@ is LHS argument (file name being generated)
# $^ is all files in same order on RHS
# $< is first file from left on RHS

%.bin: %.asm
	nasm -f bin -o $@ $< -I 'lib/'

# Build kernel entry assembly file
%.o: %.asm
	nasm -f elf -o $@ $<

#Build Main Kernel C routine
%.o: %.c ${HEADERS}
	gcc -ffreestanding -m32 -c $< -o $@

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
