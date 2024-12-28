/**********************************************************************************************************//***
 * @file board.h
 * @brief Encabezado de inicializacion de la placa.
 * @details Este archivo contiene las definiciones y declaraciones necesarias para inicializar la placa.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __BOARD_LIB_H
#define __BOARD_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stddef.h>
#include <stdint.h> 

#include "timer.h"
#include "gic.h"
#include "task_1.h"
#include "task_2.h"
#include "task_3.h"
#include "task_idle.h"
/**************************************************************************************************************/

/***************** VARIABLES EXTERNAS *************************************************************************/
extern uint32_t __svc_task1_stack_top__;
extern uint32_t __svc_task2_stack_top__;
extern uint32_t __svc_task3_stack_top__;
extern uint32_t __svc_task_idle_stack_top__;

extern uint32_t __irq_task1_stack_top__;
extern uint32_t __irq_task2_stack_top__;
extern uint32_t __irq_task3_stack_top__;
extern uint32_t __irq_task_idle_stack_top__;
/**************************************************************************************************************/

#define TASK_NUMBER		3		/**< Numero total de task. NO contempla a la task IDLE. */
#define TICKS_TASK_1	8		/**< Ticks de la task 1. */
#define TICKS_TASK_2	12		/**< Ticks de la task 2. */
#define TICKS_TASK_3	5		/**< Ticks de la task 3. */
#define TICKS_TOTAL		30		/**< Ticks totales de una ronda completa de ejecucion. */

/**********************************************************************************************************//***
 * @typedef tcb_t
 * @brief Estructura de un controlador de tarea.
 * @details Esta estructura almacena información especifica de una tarea correspondiente.
 **************************************************************************************************************/
typedef struct
{
	uint32_t*	sp_irq;			/**< Stack Pointer de la tarea en modo IRQ (al leerla el scheduler). */
	uint32_t*	sp_svc;			/**< Stack Pointer de la tarea en modo SVC (donde se guarda el contexto). */
	uint32_t	ticks;			/**< Ticks asignados a la tarea. */
	uint32_t*	task;	/**< Puntero a funcion de la tarea. Corresponde al LR (linker register), tambien apunta a donde se quedo la tarea al interrumpirse */
}tcb_t;

/**********************************************************************************************************//***
 * @brief TCB de todas las tareas.
 * @details Esta variable posee listadas todas las tareas con sus datos correspondientes para guardar contexto y ejecutar.
 **************************************************************************************************************/
__attribute__((section(".data_global"))) extern tcb_t tcb_Task [TASK_NUMBER+1];

/**********************************************************************************************************//*** 
 * @brief Función encargada del inicializar la placa.
 * @details Esta funcion realiza la inicializacion de la placa. De base, configura y enciende el GIC y el TIMER0 y inicializa todas las task. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __board_init( void );

/**********************************************************************************************************//*** 
 * @brief Función encargada de inicializar los TCB.
 * @details Inicializa todas las tareas y pone a ejecutar la primera. Rellena todos los TCB con valores del Linker Scripter y las task propiamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __stacks_init( void );

#endif	/* __BOARD_LIB_H */
