module booth2 (
    input  wire        clk  ,
	input  wire        rst_n,
	input  wire [15:0] x    ,
	input  wire [15:0] y    ,
	input  wire        start,
	output wire [31:0] z    ,
	output wire        busy 
);

reg[18:0] ext_y;
reg[1:0] state;  
reg[3:0] mul_num;
reg[31:0] result_temp;
reg[31:0] mul_x;
reg[31:0] inv_x;
reg[31:0] double_x;
reg[31:0] inv_double_x;
reg[31:0] cal_temp; 
reg busy_reg;

assign busy = busy_reg;
assign z = result_temp;

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		mul_num <= 0;
		result_temp <= 0;
		state <= 0;
		ext_y <= 0;
		mul_x <= 0;
		inv_x <= 0;
		inv_double_x <= 0;
		double_x <= 0;
	end
	else if(start || busy_reg) begin
		case(state) 
			0: begin
				ext_y <= {{2{y[15]}}, y, 1'b0};
				mul_x <= {{16{x[15]}}, x};
				double_x <= {{16{x[15]}}, x << 1};

				if(x == 0) begin
					inv_x <= 0;
					inv_double_x <= 0;
				end
				else begin
					inv_x <= {{16{~x[15]}}, ~x + 1'b1};
					inv_double_x <= {{16{~x[15]}}, ~(x << 1) + 1'b1};
				end
				mul_num <= 1'b0;
				result_temp <= 0;
				busy_reg <= 1'b1;
				state <= state + 1'b1;
			end
			1: begin
				ext_y <= ext_y >> 2;
				result_temp <= result_temp + cal_temp;
				mul_num <= mul_num + 1'b1;
				if(mul_num == 9) begin
					state <= state + 1'b1;
				end
			end
			2: begin
				busy_reg <= 1'b0;
				state <= 0;
			end
		endcase
	end
end

always@(*) begin
	case(ext_y[2:0])
		3'b000: cal_temp <= 0;
		3'b001: cal_temp <= mul_x << (2 * mul_num);
		3'b010: cal_temp <= mul_x << (2 * mul_num);
		3'b011: cal_temp <= double_x << (2 * mul_num);
		3'b100:	cal_temp <= inv_double_x << (2 * mul_num);
		3'b101:	cal_temp <= inv_x << (2 * mul_num);
		3'b110:	cal_temp <= inv_x << (2 * mul_num);
		3'b111: cal_temp <= 0;
	endcase
end

endmodule