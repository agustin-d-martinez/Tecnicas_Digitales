# Técnicas Digitales II

## Primer Cuatrimestre
 Realizado el Assembly del arranque de un sistema ARM. Posee la vectorización delas interrupciones, inicio del stack para todos los modos y pasaje del código a C.
 Una vez inicializado se realiza un TaskSwitch sencillo con 4 tareas fijas de prioridad estática utilizando el timer del microcontrolador. 
 No posee protección de memoria, dicho agregado se ve en el curso de Técnicas Digitales III.

## Segundo Cuatrimestre
 Se realizan códigos sencillos de comunicación entre una FPGA y un procesador utilizando el software Vivado 2022.2.
 La FPGA realiza el siguiente hardware descripto:
 - Módulo de comunicación AXI con el procesador.
 - Control de leds y botones.
 - BlockRam.

 El procesador se comunica con el módulo AXI y logra unir ambos procesos (el de lógica de programación y de lógica descriptiva).
 En el último ejercicio se reimplementa el mísmo código utilizando FreeRTOS con 4 tareas:
 - Tarea por default de envío de información (ejemplo Hello World). 
 - Tarea por default de recepción de información (ejemplo Hello World).
 - Tarea de manejo de leds utilizando los valores precargados en la BlockRam.
 - Tarea de lectura de los pulsadores e impresión por puerto serie. 