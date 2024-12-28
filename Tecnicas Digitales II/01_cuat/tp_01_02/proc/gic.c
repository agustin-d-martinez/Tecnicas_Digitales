
#include "../inc/gic.h"

__attribute__((section(".text"))) void __gic_init()
    {
        _gicc_t* const GICC0 = (_gicc_t*)GICC0_ADDR;        //Creo los registros GIC control 0 y GIC distribution 0
        _gicd_t* const GICD0 = (_gicd_t*)GICD0_ADDR;

        GICC0->PMR  = 0x000000F0;               //Enmascaro la prioridad mìnima que deben tener los IRQ
        GICD0->ISENABLER[1] |= 0x00000010;      //Enciendo la interrupcion del ID 36 y 44 (timer0 y timer1; UART0)
        GICD0->ISENABLER[1] |= 0x00001000;
        GICC0->CTLR         = 0x00000001;       //Enciendo la CPU interface del GIC0 en ambos registros. 
        GICD0->CTLR         = 0x00000001;       

    }