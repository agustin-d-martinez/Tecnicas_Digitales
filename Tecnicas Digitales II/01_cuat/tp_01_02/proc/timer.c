
#include "../inc/timer.h"

__attribute__((section(".text"))) void __timer_init()
    {
        _timer_t* const TIMER0 = ( _timer_t* )TIMER0_ADDR;      //Creo el registro del timer0

        TIMER0->Timer1Load     = 0x00010000;            //Cargo el valor de cuenta del timer

        //Configuro el timer
        TIMER0->Timer1Ctrl     = 0x00000002;            //Contador de 32 bits
        TIMER0->Timer1Ctrl    |= 0x00000040;            //Modo periodico (que repita)
        TIMER0->Timer1Ctrl    |= 0x00000020;            //Habilito interrupcion
        TIMER0->Timer1Ctrl    |= 0x00000080;            //Enciendo el modulo

    }