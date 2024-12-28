/*
    Definiciones necesarias: formato de salida, arquitectura y punto de entrada
*/
OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_reset_vector)


/*
    Definiciones de simbolos necesarias 
*/
_PUBLIC_RAM_INIT = 0x70010000;
_PUBLIC_STACK_INIT = 0x70020000;

_SYS_STACK_SIZE = 256;
_IRQ_STACK_SIZE = 128;
_FIQ_STACK_SIZE = 128;
_SVC_STACK_SIZE = 128;
_ABT_STACK_SIZE = 128;
_UND_STACK_SIZE = 128;


/* Tasks Stack Size*/
_TASK1_IRQ_STACK_SIZE = 512;		/*Las tareas poseen un stack propio tanto de IRQ como del Kernel*/
_TASK2_IRQ_STACK_SIZE = 512;
_TASK3_IRQ_STACK_SIZE = 512;
_TASK1_SVC_STACK_SIZE = 512;
_TASK2_SVC_STACK_SIZE = 512;
_TASK3_SVC_STACK_SIZE = 512;

/*
    Definiciòn del mapa de memoria
*/
MEMORY
{
	public_ram : org = _PUBLIC_RAM_INIT, len = 32M
	public_stack : org = _PUBLIC_STACK_INIT, len = 1M
}
/*
    Definicion de las secciones
*/
SECTIONS
{
	. = _PUBLIC_RAM_INIT;
	.text : {
		*(.text_reset_vector)
		*(.text_startup)
		*(.text*)
		} > public_ram
    
	.data : { *(.data*) }> public_ram

	.bss : {
		. = ALIGN(4);
		__bss_start__ = .;
		*(.bss*)
		__bss_end__ = .;
		} > public_ram
	.stack :
		{
			__stack_start__ = .;
			/* Kernel Stack Directory*/
			. += _IRQ_STACK_SIZE;
			. = ALIGN(4);
			__irq_stack_top__ = .;

			. += _FIQ_STACK_SIZE;
			. = ALIGN(4);
			__fiq_stack_top__ = .;

			. += _SVC_STACK_SIZE;
			. = ALIGN(4);
			__svc_stack_top__ = .;

			. += _ABT_STACK_SIZE;
			. = ALIGN(4);
			__abt_stack_top__ = .;

			. += _UND_STACK_SIZE;
			. = ALIGN(4);
			__und_stack_top__ = .;

			. += _SYS_STACK_SIZE;
			. = ALIGN(4);
			__sys_stack_top__ = .;

			/* Tasks Stack Directory*/
			. += _TASK1_IRQ_STACK_SIZE;
			. = ALIGN(4);
			__task_1_irq_stack_top__ = .;

			. += _TASK2_IRQ_STACK_SIZE;
			. = ALIGN(4);
			__task_2_irq_stack_top__ = .;

			. += _TASK3_IRQ_STACK_SIZE;
			. = ALIGN(4);
			__task_3_irq_stack_top__ = .;

			. += _TASK1_SVC_STACK_SIZE;
			. = ALIGN(4);
			__task_1_svc_stack_top__ = .;

			. += _TASK2_SVC_STACK_SIZE;
			. = ALIGN(4);
			__task_2_svc_stack_top__ = .;

			. += _TASK3_SVC_STACK_SIZE;
			. = ALIGN(4);
			__task_3_svc_stack_top__ = .;

			__stack_end__ = .;

		} > public_stack

}
