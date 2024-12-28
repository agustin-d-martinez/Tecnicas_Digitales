/**********************************************************************************************************//***
 * @file task_2.C
 * @brief Encabezado de la task 2.
 * @details Este archivo contiene la definicion de la tarea 2.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/task_2.h"
#include "../../inc/global_variable.h"

/**********************************************************************************************************//*** 
 * @brief Función de la tarea 2.
 * @details Esta funcion es una tarea generica que no termina nunca. Disminuye el valor de una variable local y una global infinitamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task2()
{
	int32_t local2 = 0;
	while (1)
	{
		var_global2--;
		local2--;
	}
}
