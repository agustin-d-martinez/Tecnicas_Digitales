.extern _PUBLIC_STACK_INIT          // Le digo al ensamblador que esto està definido afuera
.extern suma_c                      // Le digo el nombre de la funciòn a usar (no el nombre del archivo)

.global _start
.code 32                            // Indico que mi còdigo es de 32
.section .text                     

_start:
    LDR SP, =_PUBLIC_STACK_INIT     //meto SP al valor inicial del stack. LO inicializo

    MOV r0, #0x10               // cargo el 1er argumento 
    MOV r1, #0x20               // Cargo el 2do Argumento
  
    BL      suma_c                // Salto con link a la funciòn suma
                                    // Este branch sigue con la arquitectura original. en caso de tener que cambiar, usar BX

    //LDR R10, =suma_c                //guardo el lugar al que salto
    //MOV LR , PC                     //Guardo el valor de PC en el LR. Recordar que por pipeline el PC està 2 instrucciones adelantado
    //BX R10                          //Branch + exchange. salta y cambia el modo al que corresponda

    B       .
.end
