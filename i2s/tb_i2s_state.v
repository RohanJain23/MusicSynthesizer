`timescale 1ns / 1ps

module tb_i2s_state;
    parameter CLK_FREQ = 1_000_000; // 1 MHz clock
    parameter OUT_FREQ = 50_000;       // 50 kHz square wave
    
    // inputs
    reg clk;
    reg reset;
    
    // outputs
    wire lrclk;
    wire i2s_sclk;
    wire i2s_data;
    
    wire sq_wave;
    
    // Instantiate DUT
    i2s_state dut(
        .clk(clk),
        .reset(reset),
        .lrclk(lrclk),
        .i2s_sclk(i2s_sclk),
        .i2s_data(i2s_data)
    );
    
    // Separate square wave generator for debugging
    square_wave_gen #(
        .CLK_FREQ(CLK_FREQ),
        .OUT_FREQ(OUT_FREQ)
    ) dut1 (
        .clk(clk),
        .reset(reset),
        .sq_wave(sq_wave)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end 
    
    initial begin
    reset = 1;
    #20;
    reset = 0;
 
    #3_000_000;   
    $finish;
end
