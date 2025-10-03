`timescale 1ns / 1ps

module square_wave_gen #(
    parameter CLK_FREQ = 1_000_000, // system clock = 1 MHz
    parameter OUT_FREQ = 50_000        // output square wave = 50 kHz
)(
    input  wire clk,
    input  wire reset,
    output reg sq_wave
);
    integer counter;
    // Calculate number of clock cycles for half period
    localparam integer HALF_PERIOD = CLK_FREQ / (2 * OUT_FREQ);
    
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            sq_wave <= 0;
        end else begin
            if (counter >= HALF_PERIOD - 1) begin
                counter <= 0;
                sq_wave <= ~sq_wave;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
