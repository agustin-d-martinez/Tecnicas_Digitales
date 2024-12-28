/**********************************************************************************************************//***
 * @file scheduler.c
 * @brief Implementación de las funciones del scheduler.
 * @details Este archivo contiene las definiciones de las funciones del scheduler y la variable global `tcp_manager`.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/scheduler.h" 

/**********************************************************************************************************//***
 * @brief Variable global del archivo con los datos de la tarea actual.
 **************************************************************************************************************/
master_tcp_t tcp_manager = {0,0};

//	asm("CPS 0x13") <<PASO A SVC (NO CAMBIO LOS FLAGS DE INTERRUPCION)
//	asm("CPS 0x12") <<PASO A IRQ (NO CAMBIO LOS FLAGS DE INTERRUPCION)	

/**********************************************************************************************************//*** 
 * @brief Función encargada del scheduling.
 * @details Analiza el estado actual de la tarea, los ticks ya realizados, guarda su contexto en modo SVC y cambia a la sig. tarea de ser necesario. 
 * @param ctx Puntero apuntando a la posición del Stack donde se guarda el contexto de la tarea actual. Debe seguir el orden de ctx_t.
 * @return Devuelve el valor del stack al que debe regresar. En caso normal coincide con ctx, en cambio de tarea es otro.
 **************************************************************************************************************/
__attribute__((section(".text.kernel"))) uint32_t __scheduler ( ctx_t * ctx )
{
	uint32_t tarea_actual = tcp_manager.actual_task;

	tcp_manager.ticks++;
	tcb_Task[tarea_actual].sp_irq = (uint32_t*) ctx;

	if (tcp_manager.ticks >= tcb_Task[tarea_actual].ticks )	//Pregunto si pasaron los ticks
	{
		tcp_manager.ticks = 0;

		// ------ Guardo el contexto de la tarea que finaliza en su respectivo SVC. ------------------
		asm("CPS 0x13");	//Paso a SVC
		asm volatile(
			"MOV %[sp_svc] , SP\n\t"
			: [sp_svc] "=r" (tcb_Task[tarea_actual].sp_svc) 
		);	//Guardo el valor del stack svc
		
		asm volatile(
			"MOV %[lr_svc] , LR\n\t"
			: [lr_svc] "=r" (tcb_Task[tarea_actual].task) 
		);	//Guardo el valor del lr de svc

		// ------ Recupero el contexto previo de la tarea SVC. ------------------------------------------
		tarea_actual++;
		tarea_actual %= (TASK_NUMBER+1);
		tcp_manager.actual_task = tarea_actual;

		//Podrìa unir ambos asm inline en 1 solo
		asm volatile(
			"MOV LR , %[lr_svc]\n\t"
			: : [lr_svc] "r" (tcb_Task[tarea_actual].task) 
		);	//coloco el valor del lr svc

		asm volatile(
			"MOV SP, %[sp_svc]\n\t"
			"CPS 0x12"
			: : [sp_svc] "r" (tcb_Task[tarea_actual].sp_svc) 
		);	//coloco el valor del stack svc y Regreso a modo IRQ
	
	}	

	return (uint32_t) tcb_Task[tarea_actual].sp_irq;
}
