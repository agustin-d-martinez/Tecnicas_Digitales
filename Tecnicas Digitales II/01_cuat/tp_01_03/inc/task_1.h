/**********************************************************************************************************//***
 * @file task_1.h
 * @brief Encabezado de la task 1.
 * @details Este archivo contiene la definicion de la tarea 1.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __TASK_1_LIB_H
#define __TASK_1_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stdint.h>
/**************************************************************************************************************/

/**********************************************************************************************************//*** 
 * @brief Función de la tarea 1.
 * @details Esta funcion es una tarea generica que no termina nunca. Aumenta el valor de una variable local y una global infinitamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task1( void );

#endif	/* __TASK_1_LIB_H */
