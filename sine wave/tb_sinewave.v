`timescale 1ns/1ps

module tb_sinewave;

// Parameters
parameter NUM_POINTS    = 32;
parameter MAX_AMPLITUDE = 255;

// Inputs
reg clk;

// Outputs
wire [8:0] dataout;  // 9 bits enough for 0-255

// Instantiate the Unit Under Test (UUT)
sine_wave #(
    .NUM_POINTS(NUM_POINTS),
    .MAX_AMPLITUDE(MAX_AMPLITUDE)
) uut (
    .clk(clk),
    .dataout(dataout)
);

// Clock generation (10 ns period = 100 MHz)
always #5 clk = ~clk;

initial begin
    clk = 0;

    // Run long enough to see multiple sine cycles
    #(NUM_POINTS * 20 * 10); // 2 full sine cycles
    $finish;
end

initial begin
    $monitor("Time=%0t | dataout=%d", $time, dataout);
end

endmodule


