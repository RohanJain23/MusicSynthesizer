`timescale 1ns / 1ps

module sawtooth_wave (
    input  wire clk,          // clock input
    input  wire reset,        // reset input (active high)
    output reg [7:0] wave_out // sawtooth wave output
);

reg [7:0] count;  // 8-bit counter (0–255)

always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 8'd0;
    end else begin
        if (count == 8'd255)
            count <= 8'd0;
        else
            count <= count + 1;
    end
end

// Assign counter value to output
always @(*) begin
    wave_out = count;
end

endmodule

