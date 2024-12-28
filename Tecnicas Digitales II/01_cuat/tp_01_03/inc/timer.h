/**********************************************************************************************************//***
 * @file timer.h
 * @brief Encabezado del periferico timer.
 * @details Este archivo contiene las estructuras y funciones para controlar el timer.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef TIMER_LIB_H
#define TIMER_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stddef.h>
#include <stdint.h>
#include "realview-pb-a8_Registers.h"
/**************************************************************************************************************/

/**********************************************************************************************************//***
 * @typedef _timer_t
 * @brief timer register type.
 * @details Esta estructura posee los registros de uso del timer.
 **************************************************************************************************************/
typedef volatile struct
{
	__IO	uint32_t Timer1Load;		/*!< Contains the value from which the counter is to decrement. This is also the value used to reload when periodic mode enable.*/
	__I 	uint32_t Timer1Value;		/*!< Read Only. Contains the current value of the decrementing counter. */
	__IO 	uint32_t Timer1Ctrl;		/*!< Control Register. Write to enable the timer [7], set to free-running or periodic mode [6], interrupt enable [5], prescale [4] (00 not divide. 01 divide by 16. 10 ivide by 256.), timer size [1], one shot or wrapping [0] */
	__IO 	uint32_t Timer1IntClr; 		/*!< Timer 1 Interrupt Clear Register. */
	__I 	uint32_t Timer1RIS;			/*!< Read Only. Indicates the Raw interrupt status from the counter. */
	__IO 	uint32_t Timer1MIS;			/*!< Masked interrupt status register. Logical AND of RIS with the Timer Interrupt Enable bit. */
	__IO 	uint32_t Timer1BGLoad; 		/*!< Contains the value from wich the counter is to decrement. The timer does not restart when written (contrary to Timer1Load) */
	reserved_bits(0, 0x001C, 0x001F);	/*!< Espacio reservado. */
	__IO 	uint32_t Timer2Load;		/*!< Contains the value from which the counter is to decrement. This is also the value used to reload when periodic mode enable. */
	__I 	uint32_t Timer2Value;		/*!< Read Only. Contains the current value of the decrementing counter. */
	__IO 	uint32_t Timer2Ctrl;		/*!< Control Register. Write to enable the timer [7], set to free-running or periodic mode [6], interrupt enable [5], prescale [4] (00 not divide. 01 divide by 16. 10 ivide by 256.), timer size [1], one shot or wrapping [0] */
	__IO 	uint32_t Timer2IntClr; 		/*!< Timer 2 Interrupt Clear Register */
	__I 	uint32_t Timer2RIS;			/*!< Read Only. Indicates the Raw interrupt status from the counter. */
	__IO 	uint32_t Timer2MIS;			/*!< Masked interrupt status register. Logical AND of RIS with the Timer Interrupt Enable bit. */
	__IO 	uint32_t Timer2BGLoad;		/*!< Contains the value from wich the counter is to decrement. The timer does not restart when written (contrary to Timer2Load) */
	reserved_bits(1, 0x003C, 0x0EFF);	/*!< Espacio reservado. */
	__IO 	uint32_t TimerITCR;			/*!< Integration Test Control Register. Puts the timer in integration test mode. */
	__IO 	uint32_t TimerITOP;			/*!< Value output on TIMINTx when Integration Test Mode enable. */
	reserved_bits(2, 0x0F08, 0x0FDF);	/*!< Espacio reservado. */
	__IO 	uint32_t PeriphID[4];		/*!< Hardcoded, Have the ID of the peripheral. Determines the reset value. */
	__I 	uint32_t PCellID[4];		/*!< Read Only. Have the cell information of the peripheral. */
} _timer_t;	

/**********************************************************************************************************//*** 
 * @brief Función encargada del inicializar el timer.
 * @details Esta funcion realiza la inicializacion del TIMER0 y lo carga con 0x00010000.  con su prioridad. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __timer_init( void );

#endif	/* TIMER_LIB_H */
