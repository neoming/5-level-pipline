module id_ex(
    input wire rst,
    input wire clk,

    input wire [2:0] id_alu_sel_i,
    input wire [7:0] id_alu_op_i,
    input wire [31:0] id_op_number_1_i,
    input wire [31:0] id_op_number_2_i,
    input wire id_write_reg_en_i,
    input wire [4:0] id_write_reg_addr_i,

    output reg [2:0] ex_alu_sel_o,
    output reg [7:0] ex_alu_op_o,
    output reg [31:0] ex_op_number_1_o,
    output reg [31:0] ex_op_number_2_o,
    output reg ex_write_reg_en_o,
    output reg [4:0] ex_write_reg_addr_o,
);
    always @ (posedge clk) begin
        if(rst == 1'b1) begin
            ex_alu_sel_o <= 3'b000;
            ex_alu_op_o <= 8'b00000000;
            ex_op_number_1_o <= 32'h00000000;
            ex_op_number_2_o <= 32'h00000000;
            ex_write_reg_en_o <= 1'b0;
            ex_write_reg_addr_o <= 5'b00000;
        end else begin
            ex_alu_sel_o <= id_alu_sel_i;
            ex_alu_op_o <= id_alu_op_i;
            ex_op_number_1_o <= id_op_number_1_i;
            ex_op_number_2_o <= id_op_number_2_i;
            ex_write_reg_en_o <= id_write_reg_en_i;
            ex_write_reg_addr_o <= id_write_reg_addr_i;
        end
    end
endmodule