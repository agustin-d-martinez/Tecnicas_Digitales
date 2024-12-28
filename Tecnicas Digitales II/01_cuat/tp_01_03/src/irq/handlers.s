/***************** FUNC. EXTERNAS *****************************************************************************/
.extern __kernel_handler_IRQ
.extern __kernel_handler_FIQ
/**************************************************************************************************************/

/***************** VARIABLES GLOBALES *************************************************************************/
.global _UND_handler
.global _SVC_handler
.global _Prefetch_handler
.global _Abort_handler
.global _IRQ_handler
.global _FIQ_handler
/**************************************************************************************************************/

.code 32						// Indico que mi còdigo es de 32
.section .text.kernel    

_UND_handler:		//Año que viene (TDIII)
	SUB LR, LR, #4
	LDR R9, =#0x10
	B   .
_SVC_handler:		//Año que viene (TDIII)
	LDR R9, =#0x20
	B   .
_Prefetch_handler:	//Año que viene (TDIII)
	SUB LR, LR, #4
	LDR R9, =#0x30
	B   .
_Abort_handler:		//Año que viene (TDIII)
	SUB LR, LR, #8
	LDR R9, =#0x40
	B   .
_IRQ_handler:
	SUB LR, LR, #4				//Resto 1 word al LR para regresar al lugar correcto
	stmfd sp!, {r0-r12, LR}		//Guardo los valores originales antes de hacer el handler (el contexto)
	MRS R8, SPSR				//El control del modo del que vengo
	PUSH {R8}
	MOV R7, SP					//El sp! actualiza el stack pointer.
	PUSH {R7}

	MOV R0, SP  						//Si le pasara algo a mi funcion de C.
	BL  __kernel_handler_IRQ

	MOV SP, R0					//Cambio a la tarea que me devolvio en handler

	POP {R7}
	MOV SP, R7					//Recupero el stack pointer
	POP {R8}
	MSR SPSR, R8
	ldmfd sp!, {r0-r12, pc}^	//Recupero los valores originales
								//El ^ le dice que luego de saltar, vuelva a modo SVS

_FIQ_handler:
	SUB lr, lr, #4				//Resto 1 word al LR para regresar al lugar correcto
	stmfd sp!, {r0-r12, lr}		//Guardo los valores originales antes de hacer el handler (el contexto)
	MOV R7, SP					//El sp! actualiza el stack pointer.
	MRS R8, SPSR				//El control del modo del que vengo
	PUSH {R7, R8}

	BL  __kernel_handler_FIQ

	POP {R7, R8}
	MOV SP, R7					//Recupero el stack pointer
	MSR SPSR, R8
	ldmfd sp!, {r0-r12, pc}^	//Recupero los valores originales
								//El ^ le dice que luego de saltar, vuelva a modo SVS.end
