/**********************************************************************************************************//***
 * @file kernel_handlers.c
 * @brief Encabezado de los handlers.
 * @details Este archivo contiene los Handlers del lado kernel, todo escrito en C.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/kernel_handlers.h"

/**********************************************************************************************************//*** 
 * @brief Función encargada de leer las IRQ.
 * @details Analiza que periferico creo la IRQ y ejecuta su handler correspondiente. Actualmente solo implementado TIMER y UART (timer como scheduler). 
 * @param ctx  Contexto de la tarea en ejecucion actual.
 * @return	Regresa el valor de memoria donde debe colocarse el Stack Pointer al reanudar.
 **************************************************************************************************************/
__attribute__((section(".text.kernel"))) uint32_t __kernel_handler_IRQ( ctx_t *ctx )
{
	_gicc_t* const gic0 = (_gicc_t*)GICC0_ADDR;

	_timer_t* const timer0 = (_timer_t*)TIMER0_ADDR;
	_timer_t* const timer1 = (_timer_t*)TIMER1_ADDR;
	_timer_t* const timer2 = (_timer_t*)TIMER2_ADDR;
	_timer_t* const timer3 = (_timer_t*)TIMER3_ADDR;
	

	uint32_t id_handler = gic0->IAR;		//Preguntar por que IAR y no HPPIR
	uint32_t sp_regreso = (uint32_t) ctx; 

	switch (id_handler)
	{
	case GIC_SOURCE_TIMER0:
		sp_regreso = __scheduler(ctx) ;		//Codigo de mi handler del timer0....
		timer0->Timer1IntClr = 0x01;		//Limpio la interrupt en el timer
		break;
	case GIC_SOURCE_TIMER1:
		//Codigo de mi handler del timer1....
		timer1->Timer1IntClr = 0x01;
		break;
	case GIC_SOURCE_TIMER2:
		//Codigo de mi handler del timer2....
		timer2->Timer1IntClr = 0x01;
		break;
	case GIC_SOURCE_TIMER3:
		//Codigo de mi handler del timer3....
		timer3->Timer1IntClr = 0x01;
		break;

	default:
		break;
	}

	gic0->EOIR = id_handler;		//Limpio la interrupt en el GIC.
	return sp_regreso;
}

/**********************************************************************************************************//*** 
 * @brief Función encargada de leer las FIRQ.
 * @details Placeholder, no està implementada. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.kernel"))) void __kernel_handler_FIQ()		//La placa no posee FIQ
{
	while (1){ }
	
	return;
}
