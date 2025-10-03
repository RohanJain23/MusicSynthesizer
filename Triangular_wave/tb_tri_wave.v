`timescale 1ns / 1ps

module tb_tri_wave;
reg clk;
reg reset;
reg [7:0] max_val;
wire [7:0] wave_out;

tri_wave uut (
.clk(clk),
.reset(reset),
.max_val(max_val),
.wave_out(wave_out)
);

initial begin
clk = 0;
forever #5 clk = ~clk; // 10ns clock period (100 MHz clock)
end

initial begin
reset = 1; max_val = 8'd15; #10; // Set the maximum value of the triangle wave
reset = 0;
end


endmodule
