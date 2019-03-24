module inst_fetch(
    input wire rst,
    input wire clk,
    output reg [31:0] pc,
    output reg inst_sram_en
);
    always @ (posedge clk) begin
        if(rst == 1'b1) begin
            inst_sram_en <= 1'b0;
        end else begin
           inst_sram_en <= 1'b1; 
        end
    end

    always @ (posedge clk) begin
        if(inst_sram_en == 1'b0) begin
            pc <= 32'h00000000;
        end else begin
            pc <= pc + 4'h4;
        end
    end

endmodule