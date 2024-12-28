/**********************************************************************************************************//***
 * @file scheduler.h
 * @brief Encabezado del scheduler que maneja las tareas del sistema.
 * @details Este archivo contiene las definiciones y declaraciones necesarias para el funcionamiento del scheduler.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __SCHEDULER_LIB_H
#define __SCHEDULER_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stdint.h>
#include "task_1.h"
#include "task_2.h"
#include "task_3.h"
#include "task_idle.h"
#include "board.h"
/**************************************************************************************************************/

/**********************************************************************************************************//***
 * @typedef master_tcp_t
 * @brief Estructura para un controlador de tareas maestro.
 * @details Esta estructura almacena información sobre la tarea actual, incluyendo los ticks realizados y el ID de la tarea actual.
 **************************************************************************************************************/
typedef struct
{
	uint32_t ticks;			/**< Ticks ya realizados de la tarea. */
	uint32_t actual_task;	/**< ID de la tarea actual. */
}master_tcp_t;

/**********************************************************************************************************//***
 * @typedef ctx_t
 * @brief Tipo de dato "contexto" que empaqueta la información de una tarea y su ordenamiento al cambiar.
 **************************************************************************************************************/
typedef volatile struct
{
	uint32_t *sp ,		/**< Stack Pointer de la tarea. */
	spsr ,				/**< Save Process Status Register de la tarea. */
	gpr[13] ,			/**< Registros R0-R13 de la tarea. */
	*lr;				/**< Link Register de la tarea. */
} ctx_t;

/**********************************************************************************************************//*** 
 * @brief Función encargada del scheduling.
 * @details Analiza el estado actual de la tarea, los ticks ya realizados, guarda su contexto en modo SVC y cambia a la sig. tarea de ser necesario. 
 * @param ctx Puntero apuntando a la posición del Stack donde se guarda el contexto de la tarea actual. Debe seguir el orden de ctx_t.
 * @return Devuelve el valor del stack al que debe regresar. En caso normal coincide con ctx, en cambio de tarea es otro.
 **************************************************************************************************************/
__attribute__((section(".text.kernel"))) uint32_t __scheduler ( ctx_t * ctx );

#endif	/* __SCHEDULER_LIB_H */
