
/**********************************************************************************************************//***
 * @file task_3.h
 * @brief Encabezado de la task 3.
 * @details Este archivo contiene la definicion de la tarea 3.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __TASK_3_LIB_H
#define __TASK_3_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stdint.h>
/**************************************************************************************************************/

/**********************************************************************************************************//*** 
 * @brief Función de la tarea 3.
 * @details Esta funcion es una tarea generica que no termina nunca. Aumenta una variable global y disminuye otra infinitamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task3( void );

#endif	/* __TASK_3_LIB_H */