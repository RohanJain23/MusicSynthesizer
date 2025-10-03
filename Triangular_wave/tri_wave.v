`timescale 1ns / 1ps

module tri_wave (
    input clk,
    input reset,
    input [7:0] max_val,
    output reg [7:0] wave_out
);

reg [7:0] counter;
reg direction;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        direction <= 0;
        wave_out <= 0;
    end else begin
        if (direction == 0) begin
            if (counter < max_val) begin
                counter <= counter + 1;
            end else begin
                direction <= 1;
                counter <= counter - 1;
            end
        end else begin
            if (counter > 0) begin
                counter <= counter - 1;
            end else begin
                direction <= 0;
                counter <= counter + 1;
            end
        end
        wave_out <= counter;
    end
end

endmodule
