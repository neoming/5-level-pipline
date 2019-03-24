module id(
    input wire rst,
    input wire [31:0] pc_i,
    input wire [31:0] inst_i,
    //reg data
    input wire [31:0] reg1_data_i,
    input wire [31:0] reg2_data_i,
    //read enable
    output reg reg1_read_en_o,
    output reg reg2_read_en_o,
    output reg [4:0] reg1_read_addr_o,
    output reg [4:0] reg2_read_addr_o,

    //alu signal
    output reg [7:0] alu_op_o,//运算子类型
    output reg [2:0] alu_sel_o,//运算类型
    output reg [31:0] op_number_1_o,//操作数1
    output reg [31:0] op_number_2_o,//操作数2
    output reg write_reg_en_o,//寄存器写使能信号
    output reg [4:0] write_reg_addr_o,//寄存器写地址
);
    //指令分析
    wire[5:0] op1 = inst_i[31:26];
    wire[4:0] op2 = inst_i[10:6];
    wire[5:0] op3 = inst_i[5:0];
    wire[4:0] op4 = inst_i[20:16];

    reg inst_valid;
    reg[31:0] imm_number;

    //decode
    always @ (*) begin
        if(rst == 1'b1) begin
            alu_op_o <= 8'b00000000;
            alu_sel_o <= 3'b000;
            write_reg_en_o <= 1'b0;
            write_reg_addr_o <= 5'b00000;
            reg1_read_en_o <= 1'b0;
            reg2_read_en_o <= 1'b0;
            reg1_read_addr_o <= 5'b00000;
            reg2_read_addr_o <= 5'b00000;
            inst_valid <= 1'b0;
            imm_number <= 32'h0;
        end else begin
            case (op1)
                6'b001101: begin
                    write_reg_en_o <= 1'b1;
                    write_reg_addr_o <= op4;
                    alu_op_o <= 8'b00100101;
                    alu_sel_o <= 3'b001;
                    reg1_read_en_o <= 1'b1;
                    reg2_read_en_o <= 1'b0;
                    imm_number <= {16'h0,inst_i[15:0]};
                    inst_valid <= 1'b1;
                end
                default:begin
                    alu_op_o <= 8'b00000000;
                    alu_sel_o <= 3'b000;
                    write_reg_en_o <= 1'b0;
                    write_reg_addr_o <= 5'b00000;
                    reg1_read_en_o <= 1'b0;
                    reg2_read_en_o <= 1'b0;
                    reg1_read_addr_o <= 5'b00000;
                    reg2_read_addr_o <= 5'b00000;
                    inst_valid <= 1'b0;
                    imm_number <= 32'h0;
                end
            endcase
        end
    end


    always @ (*) begin
        if(rst == 1'b1) op_number_1_o <= 32'h00000000;
        else if(reg1_read_en_o == 1'b1) op_number_1_o <= reg1_data_i;
        else if(reg1_read_en_o == 1'b0) op_number_1_o <= imm_number;
        else op_number_1_o <= 32'h00000000;
    end

    always @ (*) begin
        if(rst == 1'b1) op_number_2_o <= 32'h00000000;
        else if(reg2_read_en_o == 1'b1) op_number_2_o <= reg1_data_i;
        else if(reg2_read_en_o == 1'b0) op_number_2_o <= imm_number;
        else op_number_2_o <= 32'h00000000;
    end
endmodule