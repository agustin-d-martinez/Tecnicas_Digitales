# Desarrollo de Firmware

Clonen el repositorio como ya saben hacer: 

```
git clone git@gitlab.frba.utn.edu.ar:td_piloto/2do_cuatrimestre/firmware_development.git
```

## Soporte para placas de desarrollo

Dentro de este repositorio, en **boards_support** tienen disponible las placas soportadas (hasta una determinada versión de las mismas, y eso depende de que quién les escribe recuerde anualmente actualizarlas ^^) por Vivado. A si mismo, hay un `script` tcl, *Vivado_init.tcl*, el cual deben colocar en:

```
user@machine:/home/user/.Xilinx/Vivado/20XX.X/$ 
```

y ajustan su contenido a dónde tengan clonado este repositorio. 


## Constraints

Algunos archivos de reglas (`.xdc`) completos, y que ustedes pueden ajustar a gusto para cada ejercicio. En particular, se les da para las siguientes placas de desarrollo:

* Zedboard
* Zybo
* Zybo Z7
* Pynq Z2

## HDL Sources

Como parte de los prácticos, se les da los fuentes para poder implementar una comunicación mediante el Bus AXI-4 al hardware que describan en el PL de la FPGA.

