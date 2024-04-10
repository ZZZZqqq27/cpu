`include "define.v"
`include "xgriscv_defines.v"
module xgriscv_sc(input clk, input reset,output[31:0] pc);

   

 
	
wire [31:0]pc;
	wire [31:0]ram_addr;
	wire [31:0]instr;
	wire [31:0]Rd_mem_data;
	wire [31:0]Wr_mem_data;
	wire W_en;
	wire R_en;
	wire [2:0]RW_type;
	
	imem instr_memory_inst (
    .addr(pc), 
    .instr(instr)
    );

	riscv riscv_inst (
    .clk(clk), 
    .rst_n(reset), 
    .instr(instr), 
    .Rd_mem_data(Rd_mem_data), 
    .rom_addr(pc), 
    .Wr_mem_data(Wr_mem_data), 
    .W_en(W_en), 
    .R_en(R_en), 
    .ram_addr(ram_addr), 
    .RW_type(RW_type)
    );

	
	
	
	dmem data_memory_inst (
    .clk(clk), 
    .rst_n(reset ), 
    .W_en(W_en), 
    .R_en(R_en), 
    .addr(ram_addr), 
    .RW_type(RW_type), 
    .din(Wr_mem_data), 
    .dout(Rd_mem_data)
    );	

  
endmodule


