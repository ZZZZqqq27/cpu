`include "define.v"
module control(
	opcode,
	func3,
	func7,
	MemRead,
	MemtoReg,
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
	RW_type,
	ALUctl

    );
	input 	 [6:0]opcode;
	input 	 [2:0]func3;
	input 	 func7;
	output   MemRead;
	output   MemtoReg;
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
	output   [3:0]ALUctl;
	
	wire [1:0]ALUop;
	
	main_control main_control_inst(
	.opcode(opcode),
	.func3(func3),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.ALUop(ALUop),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.lui(lui),
	.U_type(U_type),
	.jal(jal),
	.jalr(jalr),
	.beq(beq),
	.bne(bne),
	.blt(blt),
	.bge(bge),
	.bltu(bltu),
	.bgeu(bgeu),
	.RW_type(RW_type)
    );
	
	alu_control alu_control_inst(
	.ALUop(ALUop),
	.func3(func3),
	.func7(func7),
	.ALUctl(ALUctl)
    );
	
endmodule

