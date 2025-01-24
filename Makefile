all: os-image

os-image: boot.o kernel.o
    ld -m elf_i386 -T link.ld -o os.elf boot.o kernel.o
    objcopy -O binary os.elf os-image

boot.o: boot.asm
    nasm -f elf boot.asm -o boot.o

kernel.o: kernel.c
    gcc -m32 -ffreestanding -c kernel.c -o kernel.o

clean:
    rm -f *.o *.elf os-image
