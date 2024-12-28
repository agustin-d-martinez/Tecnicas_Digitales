`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 08:16:52 PM
// Design Name: 
// Module Name: led_controler_auto_fantastico
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: SECUENCIA DE AUTO-FANTÁSTICO
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_controler_auto_fantastico(
    input clk,
    input [3:0] sw,
    output reg [3:0] led
    );

// Counter for blinking effect
reg [31:0] blink_counter;

reg [5:0] led_aux = 8'b000001;

always @(posedge clk) begin
    blink_counter <= blink_counter + 1;

    if (blink_counter >= 12500000)  // 12.5 million clock cycles = 0.1 seconds @ 125MHz
    begin
        led_aux <= led_aux <<< 1;   // Toggle LED
        blink_counter <= 0;         // Reset counter
    end

    if (led_aux == 0)
    begin
        led_aux <= 8'b000001;
    end

    led[0] <= ( led_aux[0] ) & sw[0];
    led[1] <= ( led_aux[1] | led_aux[5] ) & sw[1];
    led[2] <= ( led_aux[2] | led_aux[4] ) & sw[2];
    led[3] <= ( led_aux[3] ) & sw[3];
end    
   
endmodule