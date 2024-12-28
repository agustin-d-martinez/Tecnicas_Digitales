#ifndef __BOARD_LIB_H
#define __BOARD_LIB_H

#include <stddef.h>
#include <stdint.h> 

#include "timer.h"
#include "gic.h"

__attribute__((section(".text"))) void __board_init( void );


#endif
