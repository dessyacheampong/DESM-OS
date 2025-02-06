OUTPUT_FORMAT(elf32-i386)
ENTRY(start)

SECTIONS {
    . = 0x00100000;  /* 1 MB mark, standard for kernel load */

    /* Code section */
    .text ALIGN(4K) : {
        *(.multiboot)  /* Multiboot header first */
        *(.text)       /* All code sections */
        *(.text.*)     /* Additional code sections */
    }

    /* Read-only data section */
    .rodata ALIGN(4K) : {
        *(.rodata)
        *(.rodata.*)
    }

    /* Data section */
    .data ALIGN(4K) : {
        *(.data)
        *(.data.*)
    }

    /* Uninitialized data section */
    .bss ALIGN(4K) : {
        *(COMMON)      /* Common symbols */
        *(.bss)
        *(.bss.*)
    }

    /* Discard unnecessary sections */
    /DISCARD/ : {
        *(.comment)
        *(.eh_frame)
        *(.note.gnu.build-id)
    }

    /* Kernel end symbol for memory management */
    kernel_end = .;
}
