/**********************************************************************************************************//***
 * @file task_3.C
 * @brief Encabezado de la task 3.
 * @details Este archivo contiene la definicion de la tarea 3.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/task_3.h"
#include "../../inc/global_variable.h"

/**********************************************************************************************************//*** 
 * @brief Función de la tarea 3.
 * @details Esta funcion es una tarea generica que no termina nunca. Aumenta una variable global y disminuye otra infinitamente. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text.task"))) void __task3()
{
	while (1)
	{
		var_global1--;
		var_global2++;
	}
}
