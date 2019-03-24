module inst_ram(
    input wire ce,
    input wire[31:0] data_addr,
    output reg[31:0] data
);
    reg[31:0] inst_mem[0:31]

    initial $readmemh("inst_rom.data",inst_mem);

    always @ (*) begin
        if(ce == 1'b1)begin
            data <= inst_mem[data_addr[6:2]];
        end else begin
            data <= 32'h00000000;
        end
    end
endmodule