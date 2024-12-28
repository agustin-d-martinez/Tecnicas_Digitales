#include "../inc/kernel_handlers.h"

__attribute__((section(".text"))) void __kernel_handler_IRQ( void )
{
    _gicc_t* const gic0 = (_gicc_t*)GICC0_ADDR;

    _timer_t* const timer0 = (_timer_t*)TIMER0_ADDR;
    _timer_t* const timer1 = (_timer_t*)TIMER1_ADDR;
    _timer_t* const timer2 = (_timer_t*)TIMER2_ADDR;
    _timer_t* const timer3 = (_timer_t*)TIMER3_ADDR;
    

    uint32_t id_handler = gic0->IAR;        //Preguntar por que IAR y no HPPIR

    switch (id_handler)
    {
    case GIC_SOURCE_TIMER0:
        //Codigo de mi handler del timer0....
        timer0->Timer1IntClr = 0x01;        //Limpio la interrupt en el timer
        break;
    case GIC_SOURCE_TIMER1:
        //Codigo de mi handler del timer1....
        timer1->Timer1IntClr = 0x01;
        break;
    case GIC_SOURCE_TIMER2:
        //Codigo de mi handler del timer2....
        timer2->Timer1IntClr = 0x01;
        break;
    case GIC_SOURCE_TIMER3:
        //Codigo de mi handler del timer3....
        timer3->Timer1IntClr = 0x01;
        break;

    default:
        break;
    }

    gic0->EOIR = id_handler;        //Limpio la interrupt en el GIC.
    return;
}
  
__attribute__((section(".text"))) void __kernel_handler_FIQ()           //La placa no posee FIQ
{
    while (1){ }
    
    return;
}
  
