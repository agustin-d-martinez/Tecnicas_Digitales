#include "../inc/idle.h"


__attribute__((section(".text"))) void __idle()
{
    while(1)
    {
        asm volatile (
            "wfi\n\t"
        );
    }
} 
