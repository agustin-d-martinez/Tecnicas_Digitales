`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 21:47:22
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


module led_controler(
	input clk,
	input [3:0] sw,
	output reg [3:0] led
    );
    
    always @ (posedge clk)
    begin
    	led = sw;
    end
endmodule
