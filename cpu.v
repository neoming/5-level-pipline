module cpu(
    input wire rst,
    input wire clk,

    //inst sram
    input wire [31:0]   inst_sram_read_data,
    output wire         inst_sram_wen,
    output wire [31:0]  inst_sram_addr,
    output wire [31:0]  inst_sram_write_data,
    output wire         inst_sram_en
);
    //if if_id
    wire [31:0] pc;
    wire [31:0] id_pc_i;
    wire [31:0] id_inst_i;

    //id id_ex
    wire [7:0]  id_alu_op_o;
    wire [2:0]  id_alu_sel_o;
    wire [31:0] id_op_number_1_o;
    wire [31:0] id_op_number_2_o;
    wire        id_write_reg_en_o;
    wire [4:0]  id_write_reg_addr_o;

    //id_ex ex
    wire [7:0]  ex_alu_op_i;
    wire [2:0]  ex_alu_sel_i;
    wire [31:0] ex_op_number_1_i;
    wire [31:0] ex_op_number_2_i;
    wire        ex_write_reg_en_i;
    wire [4:0]  ex_write_reg_addr_i;

    //ex ex_mem
    wire        ex_write_reg_en_o;
    wire [4:0]  ex_write_reg_addr_o;
    wire [31:0] ex_write_reg_data_o;

    //ex_mem mem
    wire        mem_write_reg_en_i;
    wire [4:0]  mem_write_reg_addr_i;
    wire [31:0] mem_write_reg_data_i;

    //mem mem_wb
    wire        mem_write_reg_en_o;
    wire [4:0]  mem_write_reg_addr_o;
    wire [31:0] mem_write_reg_data_o;

    //mem_wb reg file
    wire        wb_write_reg_en_i;
    wire [4:0]  wb_write_reg_addr_i;
    wire [31:0] wb_write_reg_data_i;

    //reg file
    wire        reg_1_read;
    wire        reg_2_read;
    wire [4:0]  reg_1_read_addr;
    wire [4:0]  reg_2_read_addr;
    wire [31:0] reg_1_read_data;
    wire [31:0] reg_2_read_data;

    assign inst_sram_addr = pc;

    inst_fetch if0(
        .rst(rst),
        .clk(clk),
        //
        .pc(pc),
        .inst_sram_en(inst_sram_en)
    );

    if_id if_id0(
        .rst(rst),
        .clk(clk),
        //
        .if_pc(pc),
        .if_inst(inst_sram_read_data),
        .id_pc(id_pc_i),
        .id_inst(id_inst_i)
    );

    id id0(
        .rst(rst),
        //
        .pc_i(id_pc_i),
        .inst_i(id_inst_i),
        //reg file
        .reg1_data_i(reg_1_read_data),
        .reg2_data_i(reg_2_read_data),
        .reg1_read_en_o(reg_1_read),
        .reg2_read_en_o(reg_2_read),
        .reg1_read_addr_o(reg_1_read_addr),
        .reg2_read_addr_o(reg_2_read_addr),
        //output
        .alu_op_o(id_alu_op_o),
        .alu_sel_o(id_alu_sel_o),
        .op_number_1_o(id_op_number_1_o),
        .op_number_2_o(id_op_number_2_o),
        .write_reg_en_o(id_write_reg_en_o),
        .write_reg_addr_o(id_write_reg_addr_o)
    );

    id_ex id_ex0(
        .rst(rst),
        .clk(clk),
        //
        .id_alu_sel_i(id_alu_sel_o),
        .id_alu_op_i(id_alu_op_o),
        .id_op_number_1_i(id_op_number_1_o),
        .id_op_number_2_i(id_op_number_2_o),
        .id_write_reg_en_i(id_write_reg_en_o),
        .id_write_reg_addr_i(id_write_reg_addr_o),

        .ex_alu_sel_o(ex_alu_sel_i),
        .ex_alu_op_o(ex_alu_op_i),
        .ex_op_number_1_o(ex_op_number_1_i),
        .ex_op_number_2_o(ex_op_number_2_i),
        .ex_write_reg_en_o(ex_write_reg_en_i),
        .ex_write_reg_addr_o(ex_write_reg_addr_i)
    );

    ex ex0(
        .rst(rst),
        //
        .alu_sel_i(ex_alu_sel_i),
        .alu_op_i(ex_alu_op_i),
        .op_number_1_i(ex_op_number_1_i),
        .op_number_2_i(ex_op_number_2_i),
        .write_reg_en_i(ex_write_reg_en_i),
        .write_reg_addr_i(ex_write_reg_addr_i),
        //
        .write_reg_en_o(ex_write_reg_en_o),
        .write_reg_addr_o(ex_write_reg_addr_o),
        .write_reg_data_o(ex_write_reg_data_o)
    );

    ex_mem ex_mem0(
        .clk(clk),
        .rst(rst),
        //
        .ex_write_reg_en_i(ex_write_reg_en_o),
        .ex_write_reg_addr_i(ex_write_reg_addr_o),
        .ex_write_reg_data_i(ex_write_reg_data_o),

        .mem_write_reg_en_o(mem_write_reg_en_i),
        .mem_write_reg_addr_o(mem_write_reg_addr_i),
        .mem_write_reg_data_o(mem_write_reg_data_i)
    );

    mem mem0(
        .rst(rst),
        //
        .write_reg_en_i(mem_write_reg_en_i),
        .write_reg_addr_i(mem_write_reg_addr_i),
        .write_reg_data_i(mem_write_reg_data_i),
        
        .write_reg_en_o(mem_write_reg_en_o),
        .write_reg_addr_o(mem_write_reg_addr_o),
        .write_reg_data_o(mem_write_reg_data_o)
    );

    mem_wb mem_wb0(
        .rst(rst),
        .clk(clk),
        //
        .mem_write_reg_en_i(mem_write_reg_en_o),
        .mem_write_reg_addr_i(mem_write_reg_addr_o),
        .mem_write_reg_data_i(mem_write_reg_data_o),

        .wb_write_reg_en_o(wb_write_reg_en_i),
        .wb_write_reg_addr_o(wb_write_reg_addr_i),
        .wb_write_reg_data_o(wb_write_reg_data_i)
    );

    reg_file regfile0(
        .rst(rst),
        .clk(clk),
        //write
        .w_addr(wb_write_reg_addr_i),
        .w_data(wb_write_reg_data_i),
        .w_en(wb_write_reg_en_i),
        //read1
        .r1_en(reg_1_read),
        .r1_addr(reg_1_read_addr),
        .r1_data(reg_1_read_data),
        //read2
        .r2_en(reg_2_read),
        .r2_addr(reg_2_read_addr),
        .r2_data(reg_2_read_data)
    );

endmodule