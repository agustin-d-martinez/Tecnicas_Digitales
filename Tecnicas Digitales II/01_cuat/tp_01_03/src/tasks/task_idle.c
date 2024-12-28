/**********************************************************************************************************//***
 * @file task_idle.h
 * @brief Encabezado de la task idle.
 * @details Este archivo contiene la definicion de la tarea ide.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/task_idle.h"

__attribute__((section(".text.task"))) void __task_idle( void )
{
	while (1)
	{
		asm volatile ("WFI");
	}
}
