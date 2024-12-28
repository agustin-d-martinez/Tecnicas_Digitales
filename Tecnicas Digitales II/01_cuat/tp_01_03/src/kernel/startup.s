/***************** FUNC. EXTERNAS *****************************************************************************/
.extern _reset_vector
.extern _UND_handler
.extern _SVC_handler
.extern _Prefetch_handler
.extern _Abort_handler
.extern _IRQ_handler
.extern _FIQ_handler

.extern __irq_stack_top__
.extern __fiq_stack_top__
.extern __svc_stack_top__
.extern __abt_stack_top__
.extern __und_stack_top__
.extern __sys_stack_top__

.extern __board_init
/**************************************************************************************************************/

/***************** VARIABLES GLOBALES *************************************************************************/
.global _start
/**************************************************************************************************************/


/***************** DEFINES ************************************************************************************/
.equ USR_MODE, 0x10
.equ FIQ_MODE, 0x11
.equ IRQ_MODE, 0x12
.equ SVC_MODE, 0x13
.equ ABT_MODE, 0x17
.equ UND_MODE, 0x1B
.equ SYS_MODE, 0x1F
.equ I_BIT, 0x80	//Aplica la mascara 0b10000000
.equ F_BIT, 0x40	//Aplica la mascara 0b01000000
/**************************************************************************************************************/

.code 32	// Indico que mi codigo es de 32
.section .text.startup  

_table_start:	//Instrucciones que seran copiadas a los handlers
	LDR PC, add_reset_vector	//Copio un salto de PC a la direcciòn del verdadero handler
	LDR PC, add_UND_vector
	LDR PC, add_SVC_vector
	LDR PC, add_Prefetch_vector
	LDR PC, add_Abort_vector
	LDR PC, add_reset_vector	//Corresponde al "reserved"
	LDR PC, add_IRQ_vector
	LDR PC, add_FIQ_vector

	add_reset_vector:	.word	_reset_vector		//<dir de reset handler>
	add_UND_vector:		.word	_UND_handler		//<dir de undefined>
	add_SVC_vector:		.word	_SVC_handler		//<dir de SVC handler>
	add_Prefetch_vector:.word	_Prefetch_handler	//<dir de Prefetch handler>
	add_Abort_vector:	.word	_Abort_handler		//<dir de Data Abort handler>
	add_IRQ_vector:		.word	_IRQ_handler		//<dir de Irq handler>
	add_FIQ_vector:		.word	_FIQ_handler		//<dir de Irq handler>

_start:
_TABLE_COPY:	//Copio la tabla aca
	MOV R0, #0                  //Dir Destino 
	LDR R1, =_table_start       //Dir Origen de tabla
	LDR R2, =_start             //Dir Final de tabla

_TABLE_LOOP:
	LDR R3, [ R1 ], #4      //Guardo lo apuntado por R1 en R3 Al finalizar, sumo 4 a r1 (una word)
	STR R3, [ R0 ], #4      //Guardo lo de R3 a lo apuntado por R0  Al finalizar, sumo 4 a r0


	CMP R1, R2				//Si R1 y R2 no son iguales, vuelvo a table loop
	BNE _TABLE_LOOP

_STACK_INIT:		//Cambiamos el modo y hacemos un load al valor de sp de dicho modo
	MSR cpsr_c,#(IRQ_MODE | I_BIT | F_BIT)
	LDR SP, =__irq_stack_top__

	MSR cpsr_c,#(FIQ_MODE | I_BIT | F_BIT)
	LDR SP, =__fiq_stack_top__

	MSR cpsr_c,#(ABT_MODE | I_BIT | F_BIT)
	LDR SP, =__abt_stack_top__

	MSR cpsr_c,#(UND_MODE | I_BIT | F_BIT)
	LDR SP, =__und_stack_top__

	MSR cpsr_c,#(SYS_MODE | I_BIT | F_BIT)
	LDR SP, =__sys_stack_top__

	MSR cpsr_c,#(SVC_MODE | I_BIT | F_BIT)
	LDR SP, =__svc_stack_top__

	LDR R10, =__board_init		//inicializo la placa
	MOV LR, PC
	BX R10
	
idle:		//Innecesario ya que board init ya inicia en una tarea.
	WFI
	B idle

.end
