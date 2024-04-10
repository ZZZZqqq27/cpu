module branch_judge(
    input beq, 
    input bne, 
    input blt, 
    input bge, 
    input bltu, 
    input bgeu, 
    input jal, 
    input jalr, 
    input zero,            // 通常用于比较操作，例如beq指令的结果
    input [31:0] ALU_result, // ALU计算的结果，可能用于blt, bge等指令的判断
    output reg jump_flag    // 跳转标志，决定是否跳转
);

// 根据不同的指令和条件设置jump_flag
always @(*) begin
    // 默认不跳转
    jump_flag = 1'b0;

    // 无条件跳转指令
    if (jal || jalr) begin
        jump_flag = 1'b1;
    end
    // 条件跳转指令
    else if (beq && zero) begin // 等于零则跳转
        jump_flag = 1'b1;
    end
    else if (bne && !zero) begin // 不等于零则跳转
        jump_flag = 1'b1;
    end
    // 以下是简化逻辑，假设ALU_result已正确设置为负（小于）或非负（大于等于）
    else if (blt && ALU_result[31]) begin // 小于则跳转
        jump_flag = 1'b1;
    end
    else if (bge && !ALU_result[31]) begin // 大于等于则跳转
        jump_flag = 1'b1;
    end
    // 对于无符号比较，逻辑需要根据实际ALU实现进行调整
    // 以下是占位逻辑，仅示意
    else if (bltu && ALU_result != 0) begin // 无符号小于
        jump_flag = 1'b1;
    end
    else if (bgeu && ALU_result == 0) begin // 无符号大于等于
        jump_flag = 1'b1;
    end
end

endmodule
