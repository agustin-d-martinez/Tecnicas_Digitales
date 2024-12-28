/**********************************************************************************************************//***
 * @file gic.h
 * @brief Encabezado del scheduler que maneja las tareas del sistema.
 * @details Este archivo contiene las definiciones y declaraciones necesarias para el funcionamiento del scheduler.
 * @author Martinez Agustin.
 **************************************************************************************************************/
#ifndef __GIC_LIB_H
#define __GIC_LIB_H

/***************** INCLUDES ***********************************************************************************/
#include <stddef.h>
#include <stdint.h>
#include "realview-pb-a8_Registers.h"
/**************************************************************************************************************/

/**********************************************************************************************************//***
 * @typedef _gicc_t
 * @brief GIC Interface Register type.
 * @details Esta estructura posee los registros de uso del gic.
 **************************************************************************************************************/
typedef volatile struct
{
	__IO uint32_t CTLR;	 /*!< CPU control. b0= Disable the CPU interface for this GIC. b1=enable the CPU interface for this GIC. */
	__IO uint32_t PMR;	 /*!< Priority Mask. Prevent interrupts from being sent to the processor. Set the minimum priority level to interrupt. */
	__IO uint32_t BPR;	 /*!< Binary point. Set the position of a 'binary point' that controls wich bits of an interrupt's priority are compared for pre-emption purpose. */
	__IO uint32_t IAR;	 /*!< Interrupt acknowlage. The processor acquires the interrupt number by reading this register. */
	__IO uint32_t EOIR;	 /*!< End Of Interrup. Contains the interrupt ID of the completed interrupt. */
	__IO uint32_t RPR;	 /*!< Running Interrupt. Contains the priority level of the currrently running interrupt. */
	__IO uint32_t HPPIR; /*!< Higgest Pending Interrupt. The interrupt number of the highest pending interrupt being presented to te CPU interface.If no interrupt = 1023. */
} _gicc_t;				 

/**********************************************************************************************************//***
 * @typedef _gicd_t
 * @brief GIC Distributor Register type.
 * @details Esta estructura posee los registros de uso del gic.
 **************************************************************************************************************/
typedef volatile struct
{
	__IO uint32_t CTLR;					/*!< Control. b0= interrupts are disable for this GIC. b1=interrupt are enable for this GIC. */
	__IO uint32_t TYPER;				/*!< Controller type. FIxed value indicating a single CPU is serviced by this GIC . Fixed value indicating 64 external interrupt input lines are available for this GIC. */
	reserved_bits(0, 0x0008, 0x00FC);	/*!< Espacio reservado. */
	__IO uint32_t ISENABLER[3];			/*!< Set-Enable.Read to determine wich interrupts are enabled. Set a bit to 1 to enable the corresponding interrupt. */
	reserved_bits(1, 0x010C, 0x017C); 	/*!< Espacio reservado. */
	__IO uint32_t ICENABLER[3];			/*!< Clear-enable. Read to determine wich interrupts are disable. Set a bit to 1 to clear the corresponding interrupt. */
	reserved_bits(2, 0x018C, 0x01FC);	/*!< Espacio reservado. */
	__IO uint32_t ISPENDR[3];			/*!< Set-pending. Read to determine wich interrupts are in pending state. Set a bit to 1 to set the corresponding interrupt into pending state. */
	reserved_bits(3, 0x020C, 0x027C);	/*!< Espacio reservado. */
	__IO uint32_t ICPENDR[3];			/*!< Clear-pending. Read to determine wich interrupts are in pending state. Set a bit to 1 to clear the corresponding interrupt into pending state. */
	reserved_bits(4, 0x028C, 0x02FC);	/*!< Espacio reservado. */
	__IO uint32_t ISACTIVER[3];			/*!< Active.Read to determine wich interrupts are in active. Set a bit to 1 to put the corresponding interrupt into active state. */
	reserved_bits(5, 0x030C, 0x03FC);	/*!< Espacio reservado. */
	__IO uint32_t IPRIORITYR[24];		/*!< Priority. Contains the priority of 4 interrupts in each of the register. Each interrupt priority is separated with a zero. Write set the priority level of the interrupt. */
	reserved_bits(6, 0x0460, 0x07FC);	/*!< Espacio reservado. */
	__IO uint32_t ITARGETSR[24];		/*!< CPU targets. Contains the CPU target of 4 interrupts in each of the register. Each interrupt CPU target is separated with a zero. Write set the CPU target of the corresponding interrupt. */
	reserved_bits(7, 0x860, 0x0BFC);	/*!< Espacio reservado. */
	__IO uint32_t ICFGR[6];				/*!< Configuration. Each register contains the configuration of 16 interrupts. AN interrupt configuration is 2 bit long. LSB = 0 indicates level sensitive. LSB = 1 indicates edge sensitive. MSB = NOT IMPLEMENTED */
	reserved_bits(8, 0x0C18, 0x0EFC);	/*!< Espacio reservado. */
	__IO uint32_t SGIR;					/*!< Software interrupts. Write only. Write to trigger an interrupt. */
	reserved_bits(9, 0x0F04, 0x0FFC);	/*!< Espacio reservado. */
} _gicd_t; 

/**********************************************************************************************************//*** 
 * @brief Función encargada del inicializar la GIC.
 * @details Esta funcion realiza la inicializacion del GIC. Activa el TIMER0, TIMER1 y UART con su prioridad. 
 * @param void  No requiere parametros.
 **************************************************************************************************************/
__attribute__((section(".text"))) void __gic_init( void );

#endif /* __BOARD_LIB_H */
