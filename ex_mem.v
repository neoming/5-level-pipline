module ex_mem(
    input wire clk,
    input wire rst,
    input wire ex_write_reg_en_i,
    input wire [4:0] ex_write_reg_addr_i,
    input wire [31:0] ex_write_reg_data_i,

    output reg mem_write_reg_en_o,
    output reg [4:0] mem_write_reg_addr_o,
    output reg [31:0] mem_write_reg_data_o,
);
    always @ (posedge clk) begin
        if(rst == 1'b1) begin
            mem_write_reg_en_o <= 1'b0;
            mem_write_reg_addr_o <= 5'b00000;
            mem_write_reg_data_o <= 32'h00000000;
        end else begin
            mem_write_reg_en_o <= ex_write_reg_en_i;
            mem_write_reg_addr_o <= ex_write_reg_addr_i;
            mem_write_reg_data_o <= ex_write_reg_data_i;
        end
    end
endmodule