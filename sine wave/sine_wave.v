`timescale 1ns / 1ps

module sine_wave #(
    parameter NUM_POINTS   = 32,   // number of LUT points
    parameter MAX_AMPLITUDE = 255  // max sine amplitude
)(
    input  wire clk,                     // clock input
    output reg  [8:0] dataout            // sine wave output (0..255 fits in 9 bits)
);

// ROM: Precomputed sine values (from your VHDL code)
reg [8:0] sine [0:NUM_POINTS-1];
initial begin
    sine[0]  = 128; sine[1]  = 152; sine[2]  = 176; sine[3]  = 198;
    sine[4]  = 218; sine[5]  = 234; sine[6]  = 245; sine[7]  = 253;
    sine[8]  = 255; sine[9]  = 253; sine[10] = 245; sine[11] = 234;
    sine[12] = 218; sine[13] = 198; sine[14] = 176; sine[15] = 152;
    sine[16] = 128; sine[17] = 103; sine[18] = 79;  sine[19] = 57;
    sine[20] = 37;  sine[21] = 21;  sine[22] = 10;  sine[23] = 2;
    sine[24] = 0;   sine[25] = 2;   sine[26] = 10;  sine[27] = 21;
    sine[28] = 37;  sine[29] = 57;  sine[30] = 79;  sine[31] = 103;
end

// index counter
reg [5:0] i = 0; // enough bits for 32 entries

always @(posedge clk) begin
    dataout <= sine[i];
    if (i == NUM_POINTS-1)
        i <= 0;
    else
        i <= i + 1;
end

endmodule
