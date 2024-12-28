## Ejercicio 1:
Para el firmware se utiliza el mismo Hardware del ejercicio 4 de la guía 1.

Para el software se utiliza FreeRTOS.
El programa lee el valor precargado en la BlockRAM y lo imprime en los leds. También lee el valor de los pulsadores y lo imprime por pantalla (serial). Para finalizar, se ejecutan de fondo dos tareas autogeneradas del Hello World de Vitis que reciben un mensaje y lo envían por pantalla.

Para realizar el objetivo se utilizan 4 tareas:
prvTxTask: Tarea autogenerada de transmisión. Escribe "Hello world" en el queue.

prvRxTask: Tarea autogenerada de recepcion. Lee si hay algo en el queue y lo imprime por pantalla.

writeLedsTask: Prepara la variable data para escribir en la blockRAM en modo lectura. Luego lee el slv5 y elimina los primeros 4 bits correspondientes a los switchs. Para finalizar imprime el valor de los leds. Como un extra, lo imprime por pantalla.

readSwitchTask: Esta tarea lee el slv5 y se queda con las primeras 4 posiciones (los switchs). Los imprime por pantalla.

* Todas las tareas poseen un delay de 1 segundo para comodidad del debbug salvo prvRxTask que queda bloqueada si el queue no tiene nada que leer.

* Hay un timer autogenerado que en el Hello_World borraba las tareas luego de 10 segundos. En este código no hace nada y su uso es innecesario.

* Las tareas se crean utilizando xTaskCreate(...). A dicha función se le pasa la tarea propiamente dicha, un nombre o token de identificación, el tamaño del stack de la tarea, las variables de entrada a la tarea (en todos los casos NULL), la prioridad y un handler para poder controlar la tarea (pausarla, reanudarla o eliminarla). En este código no se utiliza el handler.
