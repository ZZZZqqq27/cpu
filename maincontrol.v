module main_control(
	opcode,
	func3,
	MemRead,
	MemtoReg,
	ALUop,
	MemWrite,
	ALUSrc,
	RegWrite,
	lui,
	U_type,
	jal,
	jalr,
	beq,
	bne,
	blt,
	bge,
	bltu,
	bgeu,
	RW_type
    );
	input [6:0]opcode;
	input [2:0]func3;
	
	output   MemRead;
	output   MemtoReg;
	output   [1:0]ALUop;
	output   MemWrite;
	output   ALUSrc;
	output   RegWrite;
	output   lui;
	output   U_type;
	output   jal;
	output   jalr;
	output   beq;
	output   bne;
	output   blt;
	output   bge;
	output   bltu;
	output   bgeu;
	output   [2:0]RW_type;
	
	wire branch;
	wire R_type;
	wire I_type;
	wire load;
	wire store;
	wire lui;
	wire auipc;

	
	assign branch=(opcode==`B_type)?1'b1:1'b0;
	assign R_type=(opcode==`R_type)?1'b1:1'b0;
	assign I_type=(opcode==`I_type)?1'b1:1'b0;
	assign U_type=(lui | auipc)? 1'b1:1'b0;
	assign load=(opcode==`load)?1'b1:1'b0;
	assign store=(opcode==`store)?1'b1:1'b0;
	
	assign jal=(opcode==`jal)?1'b1:1'b0;
	assign jalr=(opcode==`jalr)?1'b1:1'b0;
	assign lui=(opcode==`lui)?1'b1:1'b0;
	assign auipc=(opcode==`auipc)?1'b1:1'b0;
	assign beq= branch & (func3==3'b000);
	assign bne= branch & (func3==3'b001);
	assign blt= branch & (func3==3'b100);
	assign bge= branch & (func3==3'b101);
	assign bltu= branch & (func3==3'b110);
	assign bgeu= branch & (func3==3'b111);
	assign RW_type=func3;
	
	
	enable
	assign MemRead= load;
	assign MemWrite= store;
	assign RegWrite= jal| jalr | load | I_type |R_type | U_type;
	
	MUX
	assign ALUSrc=load | store |I_type | jalr;  //select imme
	assign MemtoReg= load;  //select datamemory data
	
	ALUop
	assign ALUop[1]= R_type|branch; //R 10 I 01 B 11 add 00
	assign ALUop[0]= I_type|branch;
	
	
endmodule
