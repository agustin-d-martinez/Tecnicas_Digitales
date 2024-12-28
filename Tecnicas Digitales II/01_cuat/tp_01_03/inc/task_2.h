/**********************************************************************************************************//***
 * @file task_2.h
 * @brief Encabezado de la task 2.
 * @details Este archivo contiene la definicion de la tarea 2.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __TASK_2_LIB_H
#define __TASK_2_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stdint.h>
/**************************************************************************************************************/

/**********************************************************************************************************//*** 
 * @brief Función de la tarea 2.
 * @details Esta funcion es una tarea generica que no termina nunca. Disminuye el valor de una variable local y una global infinitamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task2( void );

#endif	/* __TASK_2_LIB_H */
