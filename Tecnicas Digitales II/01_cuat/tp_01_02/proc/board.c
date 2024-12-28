#include "../inc/board.h"

__attribute__((section(".text"))) void __board_init( void )
{
    __gic_init();
    __timer_init();

    asm volatile (      // Volatile para que no me optimice esta parte del còdigo ya que es asembler  
        "MRS R0, cpsr \n\t"     
        "BIC R0, R0,#0x80 \n\t"
        "MSR cpsr_c, R0 \n\t"
        :                       //Sin salida
        :                       //Sin entradas
        :   "memory"            //Puede modificar la memoria
    );

};
 
