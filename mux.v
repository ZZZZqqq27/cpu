module mux(
    input [31:0] data1,  // 输入端1
    input [31:0] data2,  // 输入端2
    input sel,           // 选择信号
    output [31:0] dout   // 输出端
);

assign dout = sel ? data1 : data2;

endmodule
