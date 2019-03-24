module reg_file(
    input wire rst,
    input wire clk,
    //write
    input wire [4:0] w_addr,
    input wire [31:0] w_data,
    input wire w_en,
    //read1
    input wire r1_en,
    input wire [4:0] r1_addr,
    output reg [31:0] r1_data,
    //read2
    input wire r2_en,
    input wire [4:0] r2_addr,
    output reg [31:0] r2_data
);
    reg [31:0] registers[0:31];

    //write register
    always @ (posedge clk) begin
        if(rst == 1'b0) begin
            if((w_en == 1'b1)&&(w_addr != 5'h0)) begin//reg 0 can not write
                registers[w_addr] <= w_data;
            end
        end
    end

    //read1
    always @ (*) begin
        if(rst == 1'b1) begin
            r1_data <= 32'h00000000;
        end else if(r1_en == 1'b1) begin
            if((r1_addr == w_addr)&&(w_en == 1'b1)) r1_data <= w_data;
            else if( r1_addr == 5'h0) r1_data <= 32'h00000000;
            else r1_data <= registers[r1_addr];
        end else begin
            r1_data <= 32'h00000000;
        end
    end

    //read2
    always @ (*) begin
        if(rst == 1'b1) begin
            r2_data <= 32'h00000000;
        end else if(r2_en == 1'b1) begin
            if((r2_addr == w_addr)&&(w_en == 1'b1)) r2_data <= w_data;
            else if( r2_addr == 5'h0) r2_data <= 32'h00000000;
            else r2_data <= registers[r2_addr];
        end else begin
            r2_data <= 32'h00000000;
        end
    end
endmodule