/**********************************************************************************************************//***
 * @file timer.c
 * @brief Encabezado del periferico timer.
 * @details Este archivo contiene las estructuras y funciones para controlar el timer.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#include "../../inc/timer.h"

/**********************************************************************************************************//*** 
 * @brief Función encargada del inicializar el timer.
 * @details Esta funcion realiza la inicializacion del TIMER0 y lo carga con 0x00010000.  con su prioridad. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __timer_init(void)
{
    _timer_t *const TIMER0 = (_timer_t *)TIMER0_ADDR; // Creo el registro del timer0

    TIMER0->Timer1Load = 0x00010000; // Cargo el valor de cuenta del timer

    // Configuro el timer
    TIMER0->Timer1Ctrl = 0x00000002;  // Contador de 32 bits
    TIMER0->Timer1Ctrl |= 0x00000040; // Modo periodico (que repita)
    TIMER0->Timer1Ctrl |= 0x00000020; // Habilito interrupcion
    TIMER0->Timer1Ctrl |= 0x00000080; // Enciendo el modulo
}