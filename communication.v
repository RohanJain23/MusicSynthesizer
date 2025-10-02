`timescale 1ns / 1ps

module communication(
    input rst,
    input sclk,
    input start,
    input [15:0] data,
    output reg bclk,
    output reg lrclk,
    output reg sd
    );
    
    integer i = 0;
    integer j = 16;
    reg lrclk_next; 
    
    initial begin 
        bclk <= 0;
        lrclk <= 0;
        lrclk_next <= 0;
        sd <= 0;
    end
    
    always @(posedge sclk) begin
        if (rst) begin 
            bclk <= 0;
            i <= 0;
        end
        else if (start) begin 
            if (i != 15) begin 
                i <= i + 1;
            end
            else begin 
                bclk <= ~bclk;
                i <= 0;
            end
        end
    end
    
    always @(posedge bclk) begin
        if (rst) begin
            j <= 16;
            lrclk <= 0;
            lrclk_next <= 0;
            sd <= 0;
        end
        else begin
            lrclk <= lrclk_next; 
            if (j != 1) begin
                sd <= data[j-1];
                j <= j - 1;
                lrclk_next = lrclk_next;
            end
            else if (j == 1) begin 
                sd <= data[0];
                j <= 16;
                lrclk = ~lrclk;
                lrclk_next = ~lrclk_next;
            end
        end
    end
endmodule   
