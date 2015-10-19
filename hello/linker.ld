ENTRY(_start)
SECTIONS
{
	/* Load kernel image at the base of high memory. */
	. = 1M;

	/* Multiboot header comes first since it must be within first 8K. */
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
		*(.text)
	}

	.note.gnu.build-id BLOCK(4K) : ALIGN(4K)
	{
		*(.note.gnu.build-id)
	}

	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
		*(.bootstrap_stack)
	}
}
