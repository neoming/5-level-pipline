module ex(
    input rst,
    input wire [2:0] alu_sel_i,
    input wire [7:0] alu_op_i,
    input wire [31:0] op_number_1_i,
    input wire [31:0] op_number_2_i,
    input wire write_reg_en_i,
    input wire [4:0] write_reg_addr_i,
    
    output reg write_reg_en_o,
    output reg [4:0] write_reg_addr_o,
    output reg [31:0] write_reg_data_o
);
    reg [31:0] logic_result;
    always @ (*) begin
        if(rst == 1'b1) begin
            logic_result <= 32'h00000000;
        end else begin
            case (alu_op_i) 
                8'b00100101:begin
                    logic_result <= op_number_1_i | op_number_2_i;
                end
                default: begin
                    logic_result <= 32'h00000000;
                end
            endcase
        end
    end

    always @ (*) begin
        write_reg_en_o <= write_reg_en_i;
        write_reg_addr_o <= write_reg_addr_i;
        case (alu_sel_i)
            3'b001: begin
                write_reg_data_o <= logic_result;
            end
            default: begin
                write_reg_data_o <= 32'h00000000;
            end
        endcase
    end
endmodule