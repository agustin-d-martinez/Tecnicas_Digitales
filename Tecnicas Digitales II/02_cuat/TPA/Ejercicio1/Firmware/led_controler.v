`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Student: Santiago Salerno 
// Create Date: 01.10.2024 
// Design Name: Encendido, apagado de LEDS
// Module Name: led_controler
// Project Name:  
// Description: 
// Revision:
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////


/* EJERCICIO 1: Encender led al abrir switch */
module led_controler(
 		input clk,
        input [3:0] sw,         //Es el input de los switches. El pynq tiene 4 switches   
        output reg [3:0] led   //El pynq tiene 4 leds
    );
	
    always @ (posedge clk)
    begin
        led = sw;
    end
endmodule

/* 
-Recordar que para la modificacion de los botones (btn), tengo que en el constrain habilitar los buttons 
-reg es un "registro" y me guarda el valor. 
-wire se usa cuando quiero interconectar una entrada con una salida y sin preservar el valor del medio.
*/
