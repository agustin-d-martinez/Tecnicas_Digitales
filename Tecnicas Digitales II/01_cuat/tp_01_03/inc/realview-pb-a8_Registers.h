/**********************************************************************************************************//***
 * @file realview-pb-a8_Registers.h
 * @brief Encabezado con regitros de la placa.
 * @details Este archivo contiene todas las direcciones de registros de la placa realview-pb-A8.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __REALVIEW_PB_A8_LIB_H
#define __REALVIEW_PB_A8_LIB_H

/***************** GIC REGISTERS ******************************************************************************/
#define GICC0_ADDR 0x1E000000		/*!< Address of GIC 0 Registers */
#define GICD0_ADDR 0x1E001000		/*!< Address of GIC Distribution 0 Registers */
#define GICC1_ADDR 0x1E010000		/*!< Address of GIC 1 Registers */
#define GICD1_ADDR 0x1E011000		/*!< Address of GIC Distribution 1 Registers */
#define GICC2_ADDR 0x1E020000		/*!< Address of GIC 2 Registers */
#define GICD2_ADDR 0x1E021000		/*!< Address of GIC Distribution 2 Registers */
#define GICC3_ADDR 0x1E030000		/*!< Address of GIC 3 Registers */
#define GICD3_ADDR 0x1E031000		/*!< Address of GIC Distribution 3 Registers */

#define GIC_SOURCE_TIMER0 36		/*!< Source of Timer 0 Interrupt */
#define GIC_SOURCE_TIMER1 37		/*!< Source of Timer 1 Interrupt */
#define GIC_SOURCE_TIMER2 73		/*!< Source of Timer 2 Interrupt */
#define GIC_SOURCE_TIMER3 74		/*!< Source of Timer 3 Interrupt */

#define GIC_SOURCE_UART0 44			/*!< Source of Uart 0 Interrupt */
#define GIC_SOURCE_UART1 45			/*!< Source of Uart 1 Interrupt */
#define GIC_SOURCE_UART2 46			/*!< Source of Uart 2 Interrupt */
#define GIC_SOURCE_UART3 47			/*!< Source of Uart 3 Interrupt */
/**************************************************************************************************************/

/***************** TIMER REGISTERS ****************************************************************************/
#define TIMER0_ADDR 0x10011000		/*!< Address of Timer 0 Registers */
#define TIMER1_ADDR 0x10012000		/*!< Address of Timer 1 Registers */
#define TIMER2_ADDR 0x10018000		/*!< Address of Timer 2 Registers */
#define TIMER3_ADDR 0x10019000		/*!< Address of Timer 3 Registers */
/**************************************************************************************************************/

/***************** AUXILIAR FUNCTIONS *************************************************************************/

#define reserved_bits(x,y,z) uint8_t reserved##x[z - y + 1];	/*!< Set the positions from z to y into the 'reservedx' type*/
#define __I		volatile const		/*!< Defines 'read only' permission */
#define __O		volatile			/*!< Defines 'write only' permission */
#define __IO	volatile			/*!< Defines 'read / write' permission */
/**************************************************************************************************************/

#endif	/* __REALVIEW_PB_A8_LIB_H */
