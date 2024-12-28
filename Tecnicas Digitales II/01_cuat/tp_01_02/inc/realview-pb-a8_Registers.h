#ifndef __REALVIEW_PB_A8_LIB_H
#define __REALVIEW_PB_A8_LIB_H


/*---- GIC REGISTERS ----------------------------------------------------------------------*/
#define GICC0_ADDR 0x1E000000
#define GICD0_ADDR 0x1E001000
#define GICC1_ADDR 0x1E010000
#define GICD1_ADDR 0x1E011000
#define GICC2_ADDR 0x1E020000
#define GICD2_ADDR 0x1E021000
#define GICC3_ADDR 0x1E030000
#define GICD3_ADDR 0x1E031000

#define GIC_SOURCE_TIMER0 36
#define GIC_SOURCE_TIMER1 37
#define GIC_SOURCE_TIMER2 73
#define GIC_SOURCE_TIMER3 74

#define GIC_SOURCE_UART0 44
#define GIC_SOURCE_UART1 45
#define GIC_SOURCE_UART2 46
#define GIC_SOURCE_UART3 47
/*-----------------------------------------------------------------------------------------*/

/*---- TIMER REGISTERS --------------------------------------------------------------------*/
#define TIMER0_ADDR 0x10011000
#define TIMER1_ADDR 0x10012000
#define TIMER2_ADDR 0x10018000
#define TIMER3_ADDR 0x10019000
/*-----------------------------------------------------------------------------------------*/

/*-------- AUXILIAR FUNCTIONS -------------------------------------------------------------*/
#define reserved_bits(x,y,z) uint8_t reserved##x[z - y + 1];	/*!< Set the positions from z to y into the 'reservedx' type*/
#define __I		volatile const		/*!< Defines 'read only' permission */
#define __O		volatile			/*!< Defines 'write only' permission */
#define __IO	volatile			/*!< Defines 'read / write' permission */
/*-----------------------------------------------------------------------------------------*/

#endif
