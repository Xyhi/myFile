`timescale 1ns / 1ps

module cache (
    input             clk,
    input             reset,
    input wire [12:0] addr_from_cpu,    
    input wire        rreq_from_cpu,    
    input wire        wreq_from_cpu,    
    input wire [ 7:0] wdata_from_cpu,   
    input wire [31:0] rdata_from_mem,   
    input wire        rvalid_from_mem,  
    output wire [7:0] rdata_to_cpu,     
    output wire       hit_to_cpu,       
    output reg        rreq_to_mem,     
    output reg [12:0] raddr_to_mem,     
    output wire        wreq_to_mem,      
    output reg [12:0] waddr_to_mem,     
    output reg [ 7:0] wdata_to_mem      
);

reg [4:0] current_state, next_state;        //设置读时序的状态机
reg [4:0] current_state_w, next_state_w;    //设置写时序的状态机

localparam READY        = 5'b00000,
           TAG_CHECK    = 5'b00010,
           REFILL       = 5'b00001,
           READY_W      = 5'b00100,
           TAG_CHECK_W  = 5'b01000,
           WR_DATA      = 5'b10000;

wire        wea;                        
wire [31:0] updatedata_to_mem;              //写命中时根据offset更改cache_line重新写入
wire [37:0] cache_line_r = wreq_from_cpu?   //根据wreq_from_cpu判断是从主存中直接读取数据写入cache，还是更改cache_line后重新写入?
                           {1'b1, addr_from_cpu[12:8], updatedata_to_mem}: 
                           {1'b1, addr_from_cpu[12:8], rdata_from_mem};        
wire [37:0] cache_line;                

wire [ 5:0] cache_index    = addr_from_cpu[7:2];         
wire [ 4:0] tag_from_cpu   = addr_from_cpu[12:8];        
wire [ 1:0] offset         = addr_from_cpu[1:0];         
wire        valid_bit      = cache_line[37];            
wire [ 4:0] tag_from_cache = cache_line[36:32];         

//根据读时序和写时序的状态以及tag&&valid判断命中情况
wire hit  = (tag_from_cache == tag_from_cpu) && valid_bit && (current_state == TAG_CHECK || current_state_w == TAG_CHECK_W);
wire miss = (tag_from_cache != tag_from_cpu) | (~valid_bit);

assign rdata_to_cpu = (offset == 2'b00) ? cache_line[7:0] :
                      (offset == 2'b01) ? cache_line[15:8] :
                      (offset == 2'b10) ? cache_line[23:16] : cache_line[31:24];

assign hit_to_cpu = hit;

blk_mem_gen_0 u_cache (
    .clka   (clk         ),
    .wea    (wea         ),
    .addra  (cache_index ),
    .dina   (cache_line_r),
    .douta  (cache_line  )
);

//初始化current_state和current_state_w
always @(posedge clk) begin
    if (reset) begin
        current_state <= READY;
        current_state_w <= READY_W;
    end else begin
        current_state <= next_state;
        current_state_w <= next_state_w;
    end
end

//根据读时序状态机进行状态进行转移
always @(*) begin
    case(current_state)
        READY: begin
            if (rreq_from_cpu) begin
                next_state = TAG_CHECK;
            end else begin
                next_state = READY;
            end
        end
        TAG_CHECK: begin
            if (hit) begin
                next_state = READY;
            end else if(miss && rreq_from_cpu)begin
                next_state = REFILL;
            end else begin
                next_state = TAG_CHECK;
            end
        end
        REFILL: begin
            if (rvalid_from_mem) begin
                next_state = TAG_CHECK;
            end else begin 
                next_state = REFILL;
            end
        end
        default: begin
            next_state = READY;
        end
    endcase
end

//根据写时序状态机进行状态转移
always @(*) begin
    case(current_state_w)
        READY_W: begin
            if (wreq_from_cpu) begin
                next_state_w = TAG_CHECK_W;
            end else begin
                next_state_w = READY_W;
            end
        end
        TAG_CHECK_W: begin
            if (hit) begin
                next_state_w = READY_W;
            end else if(miss && wreq_from_cpu) begin
                next_state_w = WR_DATA;
            end else begin
                next_state_w = TAG_CHECK_W;
            end
        end
        WR_DATA: begin
            next_state_w = READY_W;
        end
        default: begin
            next_state_w = READY_W;
        end
    endcase
end

//根据读时序进行cpu的读入
always @(posedge clk) begin
    if (reset) begin
        raddr_to_mem <= 0;
        rreq_to_mem  <= 0;
    end else begin
        case (next_state)
            READY: begin
                raddr_to_mem <= 0;
                rreq_to_mem  <= 0;
            end
            TAG_CHECK: begin
                raddr_to_mem <= 0;
                rreq_to_mem  <= 0;
            end
            REFILL: begin
                raddr_to_mem <= addr_from_cpu;
                rreq_to_mem  <= 1;
            end
            default: begin
                raddr_to_mem <= 0;
                rreq_to_mem  <= 0;
            end
        endcase
    end
end

//IP核写信号，在读缺失以及写命中时更改cache内容
assign wea = (current_state == REFILL && rvalid_from_mem) || (hit_to_cpu && wreq_from_cpu);
//当写命中时，通知mem进行主存相应位置修改
assign wreq_to_mem = hit && wreq_from_cpu;

//根据offset，判断写命中时需要修改的cache_line的字节的位置
assign updatedata_to_mem = (offset == 2'b00) ? {cache_line[31:24], cache_line[23:16], cache_line[15:8], wdata_from_cpu}:
                            (offset == 2'b01) ? {cache_line[31:24], cache_line[23:16], wdata_from_cpu, cache_line[ 7:0]}:
                            (offset == 2'b10) ? {cache_line[31:24], wdata_from_cpu, cache_line[15: 8], cache_line[ 7:0]}:
                                                {wdata_from_cpu, cache_line[23:16], cache_line[15: 8], cache_line[ 7:0]};

//根据写时序状态机，当next_state_w为TAG_CHECK_W时，配合wreq_to_mem进行主存写入
always @(posedge clk) begin
    if (reset) begin
        waddr_to_mem <= 0;
        wdata_to_mem <= 0;
    end else begin
        case (next_state_w)
            READY_W: begin
                waddr_to_mem <= 0;
                wdata_to_mem <= 0;
            end
            TAG_CHECK_W: begin
                waddr_to_mem <= addr_from_cpu;
                wdata_to_mem <= wdata_from_cpu;
            end
            default: begin
                waddr_to_mem <= 0;
                wdata_to_mem <= 0;
            end
        endcase
    end
end

endmodule
