module soc(

	input wire  clk,
	input wire  rst
	
);

    wire[31:0] inst_addr;
    wire[31:0] inst;
    wire inst_sram_ce;

    cpu cpu0(
		.clk(clk),
		.rst(rst),
	
		.inst_sram_en(inst_sram_ce),
		.inst_sram_read_data(inst),
		.inst_sram_addr(inst_addr)
	);
	
	inst_ram inst_ram0(
		.data_addr(inst_addr),
		.data(inst),
		.ce(inst_sram_ce)	
    );
endmodule