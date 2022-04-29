module booth (
    input  wire        clk  ,
	input  wire        rst_n,
	input  wire [15:0] x    ,
	input  wire [15:0] y    ,
	input  wire        start,
	output wire  [31:0] z    ,
	output wire        busy 
);
reg[1:0] state;
reg[3:0] mul_num;
reg[16:0] mul_x;
reg[16:0] inv_x;
reg[16:0] acc;
reg[16:0] mq;
reg busy_reg = 1'b0;
reg[16:0] cal_temp = 17'b0; 
assign busy = busy_reg;
assign z = {acc, mq[16:2]};

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        mul_num <= 0;
        mul_x <= 0;
        inv_x <= 0;
        acc <= 0;
        mq <= 0;
        state <= 0;        
    end
    else if(start || busy_reg) begin
        case(state) 
            0: begin
                mq = {y, 1'b0};
                acc <= 17'b0;
                mul_x <= {x[15],x};
                inv_x <= ~{x[15],x} + 1'b1;
                state <= state + 1'b1;
                busy_reg <= 1'b1;
            end
            1: begin
                if(mul_num == 15) begin
                    state <= state + 1'b1;
                end
                else begin
                    acc <= {cal_temp[16], cal_temp[16:1]};
                    mq <= {cal_temp[0], mq[16:1]};
                    mul_num <= mul_num + 1'b1;
                end
            end
            2: begin
                acc <= cal_temp;
                busy_reg <= 1'b0;
                state <= 1'b0;
                mul_num <= 0;
            end     
        endcase
    end
    end
    always @(*) begin 
        if(mq[1:0] == 2'b01)  cal_temp <= acc + mul_x;
        else if(mq[1:0] == 2'b10) cal_temp <= acc + inv_x;
        else cal_temp <= acc;
    end
endmodule