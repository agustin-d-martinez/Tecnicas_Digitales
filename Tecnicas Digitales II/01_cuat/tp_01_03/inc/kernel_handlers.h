/**********************************************************************************************************//***
 * @file kernel_handlers.h
 * @brief Encabezado de los handlers.
 * @details Este archivo contiene los Handlers del lado kernel, todo escrito en C.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __KERNEL_HANDLERS_LIB_H
#define __KERNEL_HANDLERS_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stddef.h>
#include <stdint.h> 

#include "timer.h"
#include "gic.h"

#include "scheduler.h"
/**************************************************************************************************************/

/**********************************************************************************************************//*** 
 * @brief Función encargada de leer las IRQ.
 * @details Analiza que periferico creo la IRQ y ejecuta su handler correspondiente. Actualmente solo implementado TIMER y UART (timer como scheduler). 
 * @param ctx  Contexto de la tarea en ejecucion actual.
 * @return	Regresa el valor de memoria donde debe colocarse el Stack Pointer al reanudar.
 **************************************************************************************************************/
__attribute__((section(".text"))) uint32_t __kernel_handler_IRQ( ctx_t *ctx );

/**********************************************************************************************************//*** 
 * @brief Función encargada de leer las FIRQ.
 * @details Placeholder, no està implementada. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __kernel_handler_FIQ( void );

#endif	/* __KERNEL_HANDLERS_LIB_H */
 
