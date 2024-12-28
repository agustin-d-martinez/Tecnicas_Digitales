/**********************************************************************************************************//***
 * @file board.c
 * @brief Encabezado de inicializacion de la placa.
 * @details Este archivo contiene las definiciones y declaraciones necesarias para inicializar la placa.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/board.h"

/**********************************************************************************************************//***
 * @brief TCB de todas las tareas.
 * @details Esta variable posee listadas todas las tareas con sus datos correspondientes para guardar contexto y ejecutar.
 **************************************************************************************************************/
__attribute__((section(".data_global"))) tcb_t tcb_Task [TASK_NUMBER+1];

//Todo deberìa estar en la section de kernel.text ....

/**********************************************************************************************************//*** 
 * @brief Función encargada del inicializar la placa.
 * @details Esta funcion realiza la inicializacion de la placa. De base, configura y enciende el GIC y el TIMER0 y inicializa todas las task. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __board_init( void )
{
	__gic_init();
	__timer_init();

	__stacks_init();
};

/**********************************************************************************************************//*** 
 * @brief Función encargada de inicializar los TCB.
 * @details Inicializa todas las tareas y pone a ejecutar la primera. Rellena todos los TCB con valores del Linker Scripter y las task propiamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __stacks_init( void )
{
	tcb_Task[0].sp_irq = &__irq_task1_stack_top__;
	tcb_Task[0].sp_svc = &__svc_task1_stack_top__;
	tcb_Task[0].task = (uint32_t*) __task1;
	tcb_Task[0].ticks = TICKS_TASK_1;

	tcb_Task[1].sp_irq = &__irq_task2_stack_top__;
	tcb_Task[1].sp_svc = &__svc_task2_stack_top__;
	tcb_Task[1].task = (uint32_t*) __task2;
	tcb_Task[1].ticks = TICKS_TASK_2;

	tcb_Task[2].sp_irq = &__irq_task3_stack_top__;
	tcb_Task[2].sp_svc = &__svc_task3_stack_top__;
	tcb_Task[2].task = (uint32_t*) __task3;
	tcb_Task[2].ticks = TICKS_TASK_3;

	tcb_Task[3].sp_irq = &__irq_task_idle_stack_top__;
	tcb_Task[3].sp_svc = &__svc_task_idle_stack_top__;
	tcb_Task[3].task = (uint32_t*) __task_idle;
	tcb_Task[3].ticks = TICKS_TOTAL-(TICKS_TASK_1+TICKS_TASK_2+TICKS_TASK_3);

	uint32_t svc_spsr;

	asm("MRS %0,CPSR":"=r"(svc_spsr));   //Guardo el CPSR en mi variable y le habilito la IRQ
	svc_spsr = svc_spsr & ~(0x80);		

	///------- Guardo el contexto iniciL IGUAL que como lo hice en handler.s ------------------
	for( int i=0; i<(TASK_NUMBER+1);i++ )	//Repetir para cada tarea
	{
		tcb_Task[i].sp_irq -= 1 ;
		*(tcb_Task[i].sp_irq) = (uint32_t) tcb_Task[i].task;		//Guardo el "LR"

		for (uint32_t j=13; j>0;j--)		//Guardo de R0 a R12
		{
			tcb_Task[i].sp_irq -= 1 ;
			*(tcb_Task[i].sp_irq) = j-1;
		}

		tcb_Task[i].sp_irq -= 1 ;
		*(tcb_Task[i].sp_irq) = svc_spsr;	//Guardo SPSR

		tcb_Task[i].sp_irq -= 1 ;
		*(tcb_Task[i].sp_irq) = (uint32_t) (tcb_Task[i].sp_irq + 1);		//Guardo el valor de SP
	}

	// Volatile para que no me optimice esta parte del còdigo ya que es asembler. Activo las interrupciones.
	asm volatile (      
		"MRS R0, cpsr \n\t"     
		"BIC R0, R0,#0x80 \n\t"
		"MSR cpsr_c, R0 \n\t"
	);

	//---- "simulo" que vuelvo de una IRQ para la primer tarea ------------- 
	asm volatile (		//Recupero el contexto y seteo el sp de la tarea 1
		"CPS 0x13 \n\t"
		"MOV SP, %[sp_svc]\n\t"
		"MOV LR, %[lr_svc]\n\t"
		"CPS 0x12 \n\t"
		"MOV SP, %[sp_tarea]\n\t"
		"POP {R7}\n\t"
		"MOV SP, R7\n\t"					
		"POP {R8}\n\t"
		"MSR SPSR, R8\n\t"
		"ldmfd sp!, {r0-r12, pc}^\n\t"				//Al finalizar me voy a la primer tarea.
		: : [sp_svc] "r" (tcb_Task[0].sp_svc) ,
			[lr_svc] "r" (tcb_Task[0].task) ,
		 	[sp_tarea] "r" (tcb_Task[0].sp_irq)
	);
}
