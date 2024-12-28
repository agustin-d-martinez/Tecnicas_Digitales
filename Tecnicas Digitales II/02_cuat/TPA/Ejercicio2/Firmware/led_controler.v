`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2024 14:57:34
// Design Name: 
// Module Name: led_controler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/*  EJERCICIO 2: Al encender el switch, hace titilar el LED por 2seg. 
Se hizo por 125Mhz, es decir 250.10^6 ciclos de clock para llegar a 2seg*/

module led_controler(
 		input clk,
        input [3:0] sw,         // Es el input de los switches. El zybo tiene 4 switches  
        output reg [3:0] led   	// El zybo tiene 4 leds
    );
	
	reg [31:0] blink_counter;
	
    always @ (posedge clk)
    begin
    	blink_counter <= blink_counter + 1;
    	
    	if(blink_counter >= 250000000) begin
    		led <= (~led) & sw;
    		blink_counter <= 0;
    	end	
    end
endmodule
