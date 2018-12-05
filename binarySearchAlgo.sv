module binarySearchAlgo #(parameter N=8) (
	
	input logic clk,
	input logic rst_n,
	input logic start,
	input logic [N-1:0] SW,
	
	output logic [4:0] output_ADDR,
	output logic found

);

//State Definitions
typedef enum logic [2:0] {
	IDLE= 3'b001, 
	SEARCH= 3'b010, 
	FINISH= 3'b100
	} statetype;
	
statetype next_state, curr_state;


logic [8:0] memDATA; //Data from memory
logic [5:0] reg_ADDR; //Address to check in memory for equivalent data
logic [5:0] next_ADDR; //Next addr to check in memory 

logic [5:0] reg_ADDR_HIGH;
logic [5:0] reg_ADDR_LOW;

logic [5:0] next_LOW;
logic [5:0] next_HIGH;

logic data_matches;   //
logic data_not_found; //

logic load; //Load SW into register during IDLE
logic [N-1:0] reg_SW;

logic start_sync; //Synchronize start signal to clk
logic restart;


logic new_addr;
logic check_upper_half;

logic match;
logic done;

memory_block sram_array(
	.address (reg_ADDR[4:0]), //no need for MSB of reg_ADDR
	.clock (clk),
	.data (),
	.wren (), 
	
	.q (memDATA)
	);


//synchronize start signal to clk
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		start_sync <= 0;
	else
		start_sync <= start;
end


//Next State Logic
always_comb
begin
	case (curr_state)
		IDLE: 
			if (start_sync)
				next_state = SEARCH;
			else 
				next_state = IDLE;
		SEARCH:
			if (done | match)
				next_state = FINISH;
			else 
				next_state = SEARCH;			
		FINISH:
			if (restart)
				next_state = IDLE;
			else 
				next_state = FINISH;				
	endcase
end

//Output Logic
always_comb
begin
//Initial values
	load = 0;
	done = 0;
	match = 0;
	restart = 0;
		
	new_addr = 0; 
	check_upper_half = 0;
		
	case (curr_state)
		IDLE: 
			begin
				load = 1;
			end	
		SEARCH: 
			begin 
				if (data_not_found) //value does not exist in memory array
					done = 1; 
				else begin
					if (data_matches)//Value found in current address
						begin
							match = 1;
						end
					else 
						begin
							new_addr = 1; //Check for value in a new address
							if (reg_SW > memDATA)
								check_upper_half = 1; //check upper half of memory
							else
								check_upper_half = 0; //check lower half of memory
						end
				end		
			end
		FINISH:
			begin
				if (start_sync == 0) //Restart state machine if start has deasserted
					restart = 1;
			end	
	endcase
end	

assign data_matches = (reg_SW == memDATA);
assign data_not_found = (reg_ADDR_LOW > reg_ADDR_HIGH);


//Found and output_ADDR[4:0] 
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		begin
			found <= 0;
			output_ADDR <= 5'h0f;
		end
	else 
		begin 
			output_ADDR <= next_ADDR;
			if (match)
				found <= 1;
			if (restart)
				found <= 0;
		end		
end	


always_comb 
begin
	casez ({new_addr, check_upper_half})
		2'b0?: //Keep full memory space accessible
			begin 
				next_HIGH =  reg_ADDR_HIGH;
				next_LOW =   reg_ADDR_LOW;
			end	
		2'b10: //Check lower chunk of memory space and modify the search address window
			begin
				next_HIGH = reg_ADDR - 1'b1; 
				next_LOW =  reg_ADDR_LOW;
			end
		2'b11: //Check upper chunk of memory space and modify the search address window
			begin
				next_HIGH = reg_ADDR_HIGH;
			   next_LOW  = reg_ADDR + 1'b1; 
			end	
		default: 
			begin
				next_HIGH =  reg_ADDR_HIGH;
				next_LOW =   reg_ADDR_LOW;
			end	
	endcase
end

assign next_ADDR = ((reg_ADDR_HIGH + reg_ADDR_LOW) >> 1); //Check the middle of the search address window for Value SW
		
//Register for ADDR
always_ff @(posedge clk)
begin
	if (!rst_n) 
		begin
			reg_ADDR_HIGH	<= 5'h1f;
			reg_ADDR_LOW 	<= 5'h00;
			reg_ADDR 		<= 5'h0f; //First address to check is d'16 (Half of RAM depth)
		end
	else 
		begin
			reg_ADDR_HIGH <= next_HIGH;
			reg_ADDR_LOW <= next_LOW;
			reg_ADDR <= next_ADDR;
		end	
end

//Algorithm below does not work!
//always_comb 
//	casez ({new_addr, check_upper})
//		0?: next_ADDR =  reg_ADDR; //Next address going to memory will be the current address- No change
//		10: next_ADDR = (reg_ADDR + (reg_ADDR>>1)) >>1; //Next address to memory will be (current address + (current address/2)) / 2 - Check lower half
//		11: next_ADDR = (reg_ADDR + 1'b1 + (reg_ADDR<<1)) >>1; //Next address to memory will be (current address + (current address*2)) / 2 - Check upper half
//		default: next_ADDR =  reg_ADDR;
//	endcase
//reg_ADDR <= (reg_ADDR + reg_ADDR<<1) >>1			
//reg_ADDF <= (reg_ADDR + reg_ADDR>>1) >>1

//State Machine Register
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		curr_state <= IDLE;
	else
		curr_state <= next_state;
end	

//Register to hold input SW
always_ff @(posedge clk) 
begin 
	if (!rst_n)
		reg_SW <= 0;
	else
		if (load)
			 reg_SW <= SW;
end


endmodule