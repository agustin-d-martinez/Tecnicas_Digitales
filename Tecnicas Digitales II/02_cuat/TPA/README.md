### Informe TPA

## Ejercicio 1:
Para realizar este ejercicio se describió un hardware con el nombre de led_controler. 
No posee grandes complicaciones, simplemente iguala un registro con los valores de entrada con los de salida.

## Ejercicio 2:
Acá se realizaron 2 descripciones de hardware. Una propia de la guía A y otra indicada en clase.
El módulo correspondiente al tpA se llama led_controler. Este módulo utiliza de base el del ejercicio 1 pero además posee un contador que realizará un toggle a los leds y solo encenderán al activar los switchs.
El contador debe llegar hasta 250 000 000 ya que se supone una frecuencia de clock de 125MHz y un titilado de 2 segundos.

El otro módulo realiza una secuencia similar a la del “auto fantástico”. 
Para lograrlo se crea un vector auxiliar del doble de tamaño que la cantidad de leds y se lo va desplazando. La primer mitad corresponderá a los leds en el inicio de secuencia y la segunda mitad corresponderá al regreso de la luz al valor inicial. Como no queremos que en los bordes se ejecute 2 veces, el tamaño en realidad es: 𝑟𝑒𝑔_𝑎𝑢𝑥=#𝑙𝑒𝑑𝑠⋅2−2
En este caso, 6.

## Ejercicio 3:
Para este ejercicio, se realizará el mismo titilado de leds del ejercicio 2 pero a través de software. Se utilizará el led_controler del ejercicio 1 simplemente como interfaz. También se usa el módulo axi_comm entregado por los profesores.
En el código en C se hará uso de las funciones en “axi_bus_driver.h” que también fueron entregadas por los profesores.
Se utiliza de base el hello world por simplicidad y para poder enviar mensajes por medio de la función print().
En el código, se crea una variable axi a la que le pasamos el valor en memoria donde fue creado dicho bus de comunicaciones en Vivado. Luego se crea un while(1) (bucle infinito) en el que se lee el valor en el slv5 (conectado a las llaves) y se escribe dicho valor en el slv0 (conectado a los leds).

## Ejercicio 4:
Para el ejercicio 4 se pide realizar una secuencia de leds genérica, guardarla en una memoria y luego escribirla en los leds. Todo esto controlado mediante software del procesador.
En la parte del firmware de vivado, se utiliza la misma base del ejercicio anterior, pero se agrega una memoria RAM simple de 2 puertos. En nuestro caso con 64 palabras de 4bits. El write enable y la habilitación del puerto A fueron puenteados puesto que el puerto A es solo para escritura.
Los Address de ambos puertos también fueron puenteados para ahorrar conexiones.
Se utiliza un único clock común a ambos puertos.
Para la comunicación, se utiliza el slv1 para todo el manejo de la memoria. Se conectaron varios slice en el siguiente orden:
- [0,0] Habilitación de puerto A (escritura)
- [1,1] Habilitación de puerto B (lecutra)
- [2,7] Address de la BRAM.
- [8,11] Data a escribir.
El slv0 se sigue utilizando exclusivamente para el manejo de salidas (en este caso los leds).
El slv5 ahora tiene concatenado el dato leído de la BRAM en las posiciones [4,7].

Para el código en C, se carga una secuencia genérica de 64 valores (en este caso, un for que repite una cuenta en binario de 0 hasta 16 cuatro veces). Para lograrlo se colocan primero los valores de address, data y enable en la variable data y luego se llama a la función axi_bus_write.
Luego entra a un bucle infinito donde realiza 3 acciones:
1) Escribe en la memoria, en el puerto de lectura, para que la BRAM nos devuelva el valor de la secuencia. 
2) Leemos dicho valor de la secuencia en el slv5 (despreciamos el valor de los pulsadores desplazando 4). 
3) Escribimos dicho valor en el slv0 correspondiente a los leds. Esperamos 1 segundo con la función sleep().

Repetimos la secuencia.