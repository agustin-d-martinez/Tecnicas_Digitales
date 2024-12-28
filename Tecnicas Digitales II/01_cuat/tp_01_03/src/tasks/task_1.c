/**********************************************************************************************************//***
 * @file task_1.h
 * @brief Encabezado de la task 1.
 * @details Este archivo contiene la definicion de la tarea 1.
 * @author Martinez Agustin.
 **************************************************************************************************************/#include "../../inc/task_1.h"
#include "../../inc/global_variable.h"

/**********************************************************************************************************//*** 
 * @brief Función de la tarea 1.
 * @details Esta funcion es una tarea generica que no termina nunca. Aumenta el valor de una variable local y una global infinitamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task1( void )
{
	int32_t local1 = 0;
	while(1)
	{
		var_global1++;
		local1++;
	}
} 
