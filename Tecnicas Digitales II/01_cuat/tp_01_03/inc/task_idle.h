/**********************************************************************************************************//***
 * @file task_idle.h
 * @brief Encabezado de la task idle.
 * @details Este archivo contiene la definicion de la tarea ide.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __TASK_IDLE_LIB_H
#define __TASK_IDLE_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stdint.h>
/**************************************************************************************************************/

/**********************************************************************************************************//*** 
 * @brief Función de idle.
 * @details Esta funcion no hace nada. En caso de haber terminado todo, se queda en WFI (Wait For Interrupt). 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task_idle( void );

#endif	/* __TASK_IDLE_LIB_H */
