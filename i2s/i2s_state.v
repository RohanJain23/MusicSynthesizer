`timescale 1ns / 1ps

module i2s_state(
    input wire clk,
    input wire reset,
    output wire lrclk,
    output wire i2s_sclk,
    output wire i2s_data    
    
);
    parameter CLK_FREQ = 1_000_000; // 1 MHz clock
    parameter OUT_FREQ = 50_000;       // 50 kHz square wave
    
    reg [5:0] count;
    reg wd;
    reg sclk;
    reg [3:0] state;
    wire data;
    
    square_wave_gen #(
        .CLK_FREQ(CLK_FREQ),
        .OUT_FREQ(OUT_FREQ)
    ) swg (
        .clk(clk),
        .reset(reset),
        .sq_wave(data)
    );
    
    always @(posedge clk) begin
        if(reset) begin
            count <= 6'd48;
            sclk <= 1'b0;
            wd <= 1'b0;
            state <= 4'b0;
        end  
        else begin
            case (state)
                0: begin
                    sclk <= 1'b0;
                    wd <= 1'b0;
                    state <= 1;
                end  
                
                1: begin
                    sclk <= 1'b0;
                    wd <= 1'b0;
                    count <= count - 1;
                    state <= 2;
                end
                
                2: begin
                    sclk <= 1'b1;
                    if(count > 23)
                        state <= 1;
                    else begin
                        state <= 3;
                        wd <= 1'b1;
                    end
                end
                
                3: begin
                    sclk <= 1'b0;
                    wd <= 1'b1;
                    count <= count - 1;
                    state <= 4;
                end   
                
                4: begin
                    sclk <= 1'b1;
                    if(count > 0)
                        state <= 3;
                    else begin
                        count <= 48;
                        state <= 0;
                    end  
                end  
                
                default: state <= 0;
            endcase
        end
    end
