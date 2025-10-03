`timescale 1ns/1ps

module tb_sawtooth;

// Testbench signals
reg clk;
reg reset;
wire [7:0] wave_out;

// Instantiate the DUT (Device Under Test)
sawtooth_wave uut (
    .clk(clk),
    .wave_out(wave_out),
    .reset(reset)
);

// Clock generation: toggle every 5 ns (100 MHz clock)
always #5 clk = ~clk;

// Stimulus
initial begin
    // Initialize signals
    clk = 0;
    reset = 1;      // assert reset
    #100;           // wait 100 ns

    reset = 0;      // deassert reset
    // Now sawtooth should start counting
end

initial begin
    $monitor("Time=%0t | reset=%b | wave_out=%d", $time, reset, wave_out);
end

endmodule
