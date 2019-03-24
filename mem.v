module mem(
    input wire rst,
    input wire write_reg_en_i,
    input wire [4:0] write_reg_addr_i,
    input wire [31:0] write_reg_data_i,
    
    output reg write_reg_en_o,
    output reg write_reg_addr_o,
    output reg write_reg_data_o
);
    always @ (*)begin
        if(rst == 1'b1) begin
            write_reg_en_o <= 1'b0;
            write_reg_addr_o <= 5'b00000;
            write_reg_data_o <= 32'h00000000;
        end else begin
            write_reg_en_o <= write_reg_en_i;
            write_reg_addr_o <= write_reg_addr_i;
            write_reg_data_o <= write_reg_data_i;
        end
    end
endmodule