#include <asm-generic/embox.lds.h>

OUTPUT_FORMAT("elf64-e2k", "elf64-e2k", "elf64-e2k")
//OUTPUT_ARCH(elbrus-v5)
OUTPUT_ARCH(elbrus-v2)
ENTRY(_start)

MEMORY {
	#include <regions.lds.h>
}

_ram_base = ORIGIN(RAM);
_ram_size = LENGTH(RAM);

SECTIONS {
	.bootinfo : {
		_bootinfo_start = .;
		/* . = 0x1000000 - 0x10000; */
		/* 0x00FF0000 */
		KEEP(*(.x86_boot));
		. = _bootinfo_start + 0x10000;
		_bootinfo_end = .;
	}

	.text : {
		_start = .;
		 _t_entry = .;
		/* Interrupt handler */
		KEEP(*(.ttable_entry0));
		. = _t_entry + 0x800;
		/* Syscall handler */
		KEEP(*(.ttable_entry1));
		. = _t_entry + 0x1000;
		/* longjmp handler */
		KEEP(*(.ttable_entry2));
		. = _t_entry + 0x1800;
		_t_entry_end = .;

		KEEP(*(.e2k_entry));
		KEEP(*(.cpu_idle));

		/* text */
	} SECTION_REGION(text)
}
