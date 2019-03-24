module mem_wb(
    input wire rst,
    input wire clk,
    input wire mem_write_reg_en_i,
    input wire [4:0] mem_write_reg_addr_i,
    input wire [31:0] mem_write_reg_data_i,

    output wire wb_write_reg_en_o,
    output wire [4:0] wb_write_reg_addr_o,
    output wire [31:0] wb_write_reg_data_o
);  

    always @ (posedge clk) begin
        if(rst == 1'b1) begin
            wb_write_reg_en_o <= 1'b0;
            wb_write_reg_addr_o <= 5'b00000;
            wb_write_reg_data_o <= 32'h00000000;
        end else begin
            wb_write_reg_en_o <= mem_write_reg_en_i;
            wb_write_reg_addr_o <= mem_write_reg_addr_i;
            wb_write_reg_data_o <= mem_write_reg_data_i;
        end
    end
endmodule