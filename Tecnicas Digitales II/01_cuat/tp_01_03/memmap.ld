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
_KERNEL_TCB = 0x70080000;

_SYS_STACK_SIZE = 256;
_IRQ_STACK_SIZE = 128;
_FIQ_STACK_SIZE = 128;
_SVC_STACK_SIZE = 128;
_ABT_STACK_SIZE = 128;
_UND_STACK_SIZE = 128;


/* Tasks Stack Size*/
_IRQ_TASK1_STACK_SIZE = 512;		/*Las tareas poseen un stack propio tanto de IRQ como del Kernel*/
_IRQ_TASK2_STACK_SIZE = 512;
_IRQ_TASK3_STACK_SIZE = 512;
_IRQ_TASK_IDLE_STACK_SIZE = 512;
_SVC_TASK1_STACK_SIZE = 512;
_SVC_TASK2_STACK_SIZE = 512;
_SVC_TASK3_STACK_SIZE = 512;
_SVC_TASK_IDLE_STACK_SIZE = 512;


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
	/*Falta cambiar esto*/
	.text : {
		*(.text.reset_vector)		
		*(.text.startup)
		*(.text.kernel)
		*(.text.task)
		*(.text*)
		} > public_ram
    
	.data : { 
		*(.data_global)
		*(.data*)
		}> public_ram

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
			. += _IRQ_TASK1_STACK_SIZE;
			. = ALIGN(4);
			__irq_task1_stack_top__ = .;

			. += _IRQ_TASK2_STACK_SIZE;
			. = ALIGN(4);
			__irq_task2_stack_top__ = .;

			. += _IRQ_TASK3_STACK_SIZE;
			. = ALIGN(4);
			__irq_task3_stack_top__ = .;

			. += _IRQ_TASK_IDLE_STACK_SIZE;
			. = ALIGN(4);
			__irq_task_idle_stack_top__ = .;

			. += _SVC_TASK1_STACK_SIZE;
			. = ALIGN(4);
			__svc_task1_stack_top__ = .;

			. += _SVC_TASK2_STACK_SIZE;
			. = ALIGN(4);
			__svc_task2_stack_top__ = .;

			. += _SVC_TASK3_STACK_SIZE;
			. = ALIGN(4);
			__svc_task3_stack_top__ = .;

			. += _SVC_TASK_IDLE_STACK_SIZE;
			. = ALIGN(4);
			__svc_task_idle_stack_top__ = .;
			__stack_end__ = .;

		} > public_stack

}
