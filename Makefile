CC = gcc
NASM = nasm
LD = ld

CFLAGS = -m32 -ffreestanding -Wall -Wextra -nostdlib -nostdinc -fno-builtin -fno-stack-protector -fno-pic
NASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T link.ld

all: os-image

os-image: boot.o kernel.o
	$(LD) $(LDFLAGS) -o os.elf boot.o kernel.o
	objcopy -O binary os.elf os-image

boot.o: boot.asm
	$(NASM) $(NASMFLAGS) boot.asm -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

clean:
	rm -f *.o *.elf os-image
