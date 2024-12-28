/*    1 tab == 4 spaces!*/

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
/* Xilinx includes. */
#include "xil_printf.h"
#include "xparameters.h"
#include "axi_bus_driver.h"

#define TIMER_ID	1
#define DELAY_10_SECONDS	10000UL
#define DELAY_1_SECOND		1000UL
#define TIMER_CHECK_THRESHOLD	9
/*-----------------------------------------------------------*/

/* Tasks. */
static void prvTxTask( void *pvParameters );
static void prvRxTask( void *pvParameters );
static void vTimerCallback( TimerHandle_t pxTimer );

static void writeLedsTask( void *pvParameters );
static void readSwitchTask( void *pvParameters );
/*-----------------------------------------------------------*/

#define AXI_READ	5
#define AXI_BRAM	1
#define AXI_LEDS	0

#define BRAM_DEPTH	64


/* The queue used by the Tx and Rx tasks, as described at the top of this
file. */
static TaskHandle_t xTxTask;
static TaskHandle_t xRxTask;
static QueueHandle_t xQueue = NULL;
static TimerHandle_t xTimer = NULL;
char HWstring[15] = "Hello World";

static TaskHandle_t xwriteLedsTask;
static TaskHandle_t xreadSwitchTask;

axi4_bus_device_t axi4_bus_0 = {.base_address = NULL , .is_open =  false};

int main( void )
{
	const TickType_t x10seconds = pdMS_TO_TICKS( DELAY_10_SECONDS );
	xil_printf( "Hello from Freertos example main\r\n" );




	uint32_t data = 0;
    axi4_bus_open(&axi4_bus_0, (uint32_t *)XPAR_AXI_COMM_BUS_0_BASEADDR );

	xil_printf( "Hello from Freertos example main\r\n" );

	/* Create the two tasks.  The Tx task is given a lower priority than the
	Rx task, so the Rx task will leave the Blocked state and pre-empt the Tx
	task as soon as the Tx task places an item in the queue. */
	xTaskCreate( 	prvTxTask, 					/* The function that implements the task. */
					( const char * ) "Tx", 		/* Text name for the task, provided to assist debugging only. */
					configMINIMAL_STACK_SIZE, 	/* The stack allocated to the task. */
					NULL, 						/* The task parameter is not used, so set to NULL. */
					tskIDLE_PRIORITY+1,			/* The task runs at the idle priority. */
					&xTxTask );

	xTaskCreate( prvRxTask,
				 ( const char * ) "GB",
				 configMINIMAL_STACK_SIZE,
				 NULL,
				 tskIDLE_PRIORITY + 2,
				 &xRxTask );

	xTaskCreate( writeLedsTask, 					/* The function that implements the task. */
				( const char * ) "Write", 		/* Text name for the task, provided to assist debugging only. */
				configMINIMAL_STACK_SIZE, 	/* The stack allocated to the task. */
				NULL, 						/* The task parameter is not used, so set to NULL. */
				tskIDLE_PRIORITY,			/* The task runs at the idle priority. */
				&xwriteLedsTask );

	xTaskCreate( readSwitchTask,
				( const char * ) "Read",
				configMINIMAL_STACK_SIZE,
				NULL,
				tskIDLE_PRIORITY,
				&xreadSwitchTask );

	/* Create the queue used by the tasks. NOT USED*/
	xQueue = xQueueCreate(1, sizeof( HWstring ) );	/* Each space in the queue is large enough to hold a uint32_t. */

	/* Check the queue was created. */
	configASSERT( xQueue );

	xTimer = xTimerCreate( (const char *) "Timer",		/* Creo el Timer */
							x10seconds,
							pdFALSE,
							(void *) TIMER_ID,
							vTimerCallback);
	/* Check the timer was created. */
	configASSERT( xTimer );


	/* Guardo la data en la BlockRAM */
	for ( uint32_t i=0 ; i < BRAM_DEPTH ; i++ )
	{
		data = 0;
	    data |= (1) | ((i & 0b111111) << 2) | ((i & 0b1111) << 8);

		axi4_bus_write(&axi4_bus_0, AXI_BRAM, data);	//Guardo
		xil_printf("%04x\r\n",data);
	}
	print("termine de guardar en la memoria\n\r");

	/* Start the tasks and timer running. */
	xTimerStart( xTimer, 0 );
	vTaskStartScheduler();

	for( ;; );
}


/*-----------------------------------------------------------*/
static void prvTxTask( void *pvParameters )
{
const TickType_t x1second = pdMS_TO_TICKS( DELAY_1_SECOND );

	for( ;; )
	{
		/* Delay for 1 second. */
		vTaskDelay( x1second );

		/* Send the next value on the queue.  The queue should always be
		empty at this point so a block time of 0 is used. */
		xQueueSend( xQueue,			/* The queue being written to. */
					HWstring, /* The address of the data being sent. */
					0UL );			/* The block time. */
	}
}

static void prvRxTask( void *pvParameters )
{
char Recdstring[15] = "";

	for( ;; )
	{
		/* Block to wait for data arriving on the queue. */
		xQueueReceive( 	xQueue,				/* The queue being read. */
						Recdstring,	/* Data is read into this address. */
						portMAX_DELAY );	/* Wait without a timeout for data. */

		/* Print the received data. */
		xil_printf( "Rx task received string from Tx task: %s\r\n", Recdstring );
	}
}

static void vTimerCallback( TimerHandle_t pxTimer )
{
	long lTimerId;
	configASSERT( pxTimer );

	lTimerId = ( long ) pvTimerGetTimerID( pxTimer );

	if (lTimerId != TIMER_ID) {
		xil_printf("FreeRTOS Hello World Example FAILED");
	}
}

/*-----------------------------------------------------------*/
static void writeLedsTask( void *pvParameters )
{
	uint32_t data = 0, idx = 0, leds = 0;

	const TickType_t x1second = pdMS_TO_TICKS( DELAY_1_SECOND );

	for( ;; )
	{
		vTaskDelay( x1second );	/* Delay for 1 second. */

		data = 0;
		data |= (1 << 1) | ((idx & 0b111111) << 2);
		axi4_bus_write(&axi4_bus_0, AXI_BRAM, data);	//Le digo a la memoria que lea
		axi4_bus_read(&axi4_bus_0, AXI_READ, &leds);				//Leo la memoria

		leds = leds >> 4;	//Los primeros 4 bits son los switches (ver design)
		xil_printf("leds: %d\r\n", leds);
		axi4_bus_write(&axi4_bus_0, AXI_LEDS, leds);	//Escribo los leds

		idx++;
		idx %= BRAM_DEPTH;
	}
}

/*-----------------------------------------------------------*/
static void readSwitchTask( void *pvParameters )
{
	const TickType_t x1second = pdMS_TO_TICKS( DELAY_1_SECOND );
	uint32_t data;
	for( ;; )
	{
		vTaskDelay( x1second );
		axi4_bus_read(&axi4_bus_0, AXI_READ, &data);				//Leo la memoria
		data &= 0b1111;
		xil_printf("Pulsadores: %04X\r\n", data);
	}
}


