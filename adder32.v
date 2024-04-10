module cla_adder32(
    input [31:0] A, 
    input [31:0] B,
    input cin,
    output [31:0] result,
    output cout
);
    wire [31:0] g; // 生成器
    wire [31:0] p; // 传播器
    wire [31:0] c; // 进位

    // 生成器和传播器的定义
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_prop
            assign g[i] = A[i] & B[i];
            assign p[i] = A[i] | B[i];
        end
    endgenerate

    // 进位的定义
    assign c[0] = cin;
    generate
        for (i = 1; i < 32; i = i + 1) begin : carry_lookahead
            assign c[i] = g[i-1] | (p[i-1] & c[i-1]);
        end
    endgenerate
    assign cout = g[31] | (p[31] & c[31]);

    // 结果的计算
    assign result = A ^ B ^ c;

endmodule
