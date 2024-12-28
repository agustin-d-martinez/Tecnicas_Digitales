/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#include "axi_bus_driver.h"
//#include "system_generics.h"

#define AXI_READ	5
#define AXI_BRAM	1
#define AXI_LEDS	0

#define BRAM_DEPTH	64
/*
typedef union {
	struct {
		uint32_t ena_write	:1;
		uint32_t ena_read	:1;
		uint32_t addr		:6;
		uint32_t data		:4;
		uint32_t NP			:20;
	};
	uint32_t raw_data;
} bram_data_type;*/

int main()
{
    uint32_t idx = 0, leds = 0, sleep_time = 0;
    uint32_t data = 0;
    axi4_bus_device_t axi4_bus_0 = {.base_address = NULL , .is_open =  false};

	init_platform();

    print("Hello World\n\r");

    sleep_time = 1;		//Secuencia cambia cada 1 seg.

    axi4_bus_open(&axi4_bus_0, (uint32_t *)XPAR_AXI_COMM_BUS_0_BASEADDR );

    //-----------guardo secuencia----------
    for ( uint32_t i=0 ; i < BRAM_DEPTH ; i++ )
    {
    	data = 0;
    	data |= 1;
    	data |= ((i & 0b111111) << 2);
    	data |= ((i & 0b1111) << 8);

		axi4_bus_write(&axi4_bus_0, AXI_BRAM, data);	//Guardo
		xil_printf("%04x\n",data);
    }
    print("termine de guardar\n\r");
	//-------------------------------------

	while ( 1 )
	{
		data = 0;
		data |= 1 << 1;
		data |= ((idx & 0b111111) << 2);
		axi4_bus_write(&axi4_bus_0, AXI_BRAM, data);	//Le digo a la memoria que lea


		axi4_bus_read(&axi4_bus_0, AXI_READ, &leds);				//Leo la memoria
		xil_printf("%d\n", leds);
		leds = leds >> 4;	//Los primeros 4 bits son los switches (ver design)

		axi4_bus_write(&axi4_bus_0, AXI_LEDS, leds);	//Escribo los leds

		idx++;
		idx %= BRAM_DEPTH;

		sleep(sleep_time);
	}

    cleanup_platform();
    return 0;
}
