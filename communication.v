`timescale 1ns / 1ps

module communication(
    input rst,
    input bclk,
    input option,
    input start,
    input [15:0] frame0, frame1, frame2, frame3,
    output reg lrclk,
    output reg sd,
    output [1:0] state_out
    );
    
    integer signed i = 15;
    reg [1:0] state = 0;
    
    assign state_out = state;
    
    always @(posedge bclk) begin
        if (rst) begin
            i <= 15;
            state <= 0;
            lrclk <= 0;
            sd <= 0;
        end
        else if (start) begin
            lrclk <= option;
            case (state) 
                2'b00: begin
                    if ( i != 0) begin
                        sd <= frame0[i];
                        i <= i - 1;
                    end
                    else begin
                        sd <= frame0[0];
                        i <= 15;
                        state <= 2'b01;
                    end
                end
                2'b01: begin
                    if ( i != 0) begin
                        sd <= frame1[i];
                        i <= i - 1;
                    end
                    else begin
                        sd <= frame1[0];
                        i <= 15;
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if ( i != 0) begin
                        sd <= frame2[i];
                        i <= i - 1;
                    end
                    else begin
                        sd <= frame2[0];
                        i <= 15;
                        state <= 2'b11;
                    end
                end
                2'b11: begin
                    if ( i != 0) begin
                        sd <= frame3[i];
                        i <= i - 1;
                    end
                    else begin
                        sd <= frame3[0];
                        i <= 15;
                        state <= 1'bx;
                    end
                end
            endcase
        end
    end
    
endmodule
