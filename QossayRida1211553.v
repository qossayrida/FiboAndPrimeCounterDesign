// Qossay Rida 1211553
module counter (input clk,PorF,UorD,reset,enable,output [6:1]Q); 	 
	
	wire [6:1]TQ; // input for flip flop
	reg [6:1]T;	// initial state of flip flop
	reg w , z; 
	// w: work as reset (when happend any change in PorF or UorD)
	// z: work as enable (to diable counter for one clock when present state= 1)
	   
	// input for each flip flop
	assign TQ[1] = (~Q [1]) | (UorD & ~Q [5] & ~Q[4] & ~Q [3]) | (PorF & UorD & Q[4]) | (~UorD & Q[4] & Q [3] & Q[2]) | (PorF & ~UorD & ~Q[4] & ~Q[2]) | (PorF & Q [3] & Q[2]);
	assign TQ[2] = (~UorD & ~Q [5] & ~Q [3] & Q [1]) | (~UorD & Q [5] & ~Q[4] & Q [3]) | (UorD & Q [5] & ~Q [3] & Q[2]) | (UorD & ~Q [5] & ~Q[4] & Q [3]) | (~PorF & ~UorD & ~Q[4] & ~Q[2]) | (~PorF & Q [5] & Q [3] & ~Q[2]) | (~PorF & UorD & Q[4] & Q [3]) | (PorF & UorD & ~Q[4] & ~Q [1]);
	assign TQ[3] = (~PorF & ~Q [5] & Q[4]) | (~UorD & Q[4] & Q[2]) | (~PorF & UorD & ~Q [1]) | (Q[6]) | (UorD & ~Q[2] & ~Q [1]) | (~UorD & ~Q [5] & Q[2] & Q [1]) | (~UorD & ~Q [3] & Q[2] & Q [1]) | (~PorF & UorD & ~Q[4] & ~Q[2]) | (~PorF & UorD & Q [5] & ~Q[4] & Q [3]) | (PorF & ~UorD & ~Q[4] & Q [3]) | (Q[4] & ~Q [3]) | (UorD & ~Q [5] & Q [3] & ~Q[2]);
	assign TQ[4] = (~PorF & UorD & ~Q[4] & ~Q [1]) | (UorD & Q [5] & ~Q[2]) | (PorF & ~UorD & ~Q [5] & Q [3]) | (~PorF & ~UorD & Q [3] & Q[2]) | (~PorF & ~UorD & ~Q [5] & Q[4] & ~Q[2]) | (UorD & ~Q [5] & Q[4] & Q[2] & Q [1]) | (UorD & Q[4] & ~Q [3] & ~Q[2]);
	assign TQ[5] = (~PorF & UorD & ~Q[4] & ~Q [1]) | (Q[6]) | (UorD & ~Q[4] & ~Q[2] & ~Q [1]) | (~UorD & ~Q [5] & Q[4] & ~Q[2] & Q [1]) | (~UorD & Q[4] & Q [3] & Q[2]) | (~PorF & UorD & ~Q [3] & ~Q[2]) | (Q [5] & ~Q[4] & Q [3] & ~Q[2]);
	assign TQ[6] = (UorD & ~Q[4] & ~Q[2] & ~Q [1]) | (PorF & ~UorD & Q [5] & Q [3]) | (UorD & Q[6] & ~Q [5]);
	
	// call T flip flop six times
	TFF t1(TQ[1],clk,w,T[1],z,Q[1]);
	TFF t2(TQ[2],clk,w,T[2],z,Q[2]);
	TFF t3(TQ[3],clk,w,T[3],z,Q[3]);
	TFF t4(TQ[4],clk,w,T[4],z,Q[4]);  
	TFF t5(TQ[5],clk,w,T[5],z,Q[5]);  
	TFF t6(TQ[6],clk,w,T[6],z,Q[6]);
	
	// this always to control about initial state and the state when reset counter
	always @(negedge reset or PorF or UorD) begin 
		w=reset ;
		// choose suitable state
		if (PorF && ~UorD)
			T=0;
		else if (~PorF && ~UorD)
			T=2;
		else if (PorF && UorD)
			T=55;
		else 
			T=31;
		w=0;
		#1ns w=1;

	end
	
	// this always to disable counter for one clock when present state equal 1
	always @(posedge clk or enable) begin 
		if (Q==0 && z && UorD==0 && PorF)
			z=0;
		else if (Q==2 && z && UorD && PorF)
			z=0;
		else
			z = enable ;
	end
	
endmodule


module TFF (input T,clk,reset,initialState,enable,output reg Q);

  	always @(posedge clk or negedge reset ) begin 
	  	if (enable)// if enable= 1 go to next state 
		  if(~reset) // active low reset
			  Q=initialState;
 		  else 
			  Q=Q^T;

  	end

endmodule		

module testGenerater (clk ,PorF,UorD ,reset , enable,Q) ;
	output reg clk ,PorF,UorD ,reset , enable ;
	output reg [6:1] Q ;
	
	// generating input for the counter
	initial begin  
		clk = 0;
		UorD = 0 ;
		PorF = 0; 
		reset = 0 ;
		enable = 1 ;
		#10ns reset=1 ;	
		#50ns UorD = 1 ;
			  PorF = 1; 
		
		#60ns PorF = 0;   
		
		#100ns UorD = 0 ;
			   PorF = 1; 
	
		
	end	  
	
	initial begin 	 
		repeat(100)
		#20ns clk=~clk ;
	end
	
	//calculating the expected output for this input
	reg flag ,flag1; 
	
	// control about state when PorF UorD change
	always @(negedge reset or PorF or UorD) begin
		flag1=0;
		if (PorF && ~UorD)
			Q=0;
		else if (~PorF && ~UorD)
			Q=2;
		else if (PorF && UorD)
			Q=55;
		else 
			Q=31;
		#1ns flag1=1;
	end	
	
	
	// behavioral counter to calculate expected result
	always @(posedge clk) begin
		if (enable && flag1)	// if the counter enable go to next state
		if (PorF==0 && UorD==0)	// choose suitable next state
			case (Q)
				2: Q=3;
				3: Q=5;
				5: Q=7;
				7: Q=11;
				11: Q=13;
				13: Q=17;
				17: Q=19;
				19: Q=23;
				23: Q=29;
				29: Q=31;
				31: Q=2;
			endcase
		else if (PorF==0 && UorD==1)
			case (Q)
				2: Q=31;
				3: Q=2;
				5: Q=3;
				7: Q=5;
				11: Q=7;
				13: Q=11;
				17: Q=13;
				19: Q=17;
				23: Q=19;
				29: Q=23;
				31: Q=29;
			endcase
		else if (PorF==1 && UorD==0 ) begin
			if (Q!=1)
				flag=0;
			case ({Q,flag})
				0: 	begin	// control about state 1 apper 2 times
					Q=1;
					flag=1;
					end
				3: flag=0;
				2: Q=2;
				4: Q=3;
				6: Q=5;
				10: Q=8;
				16: Q=13;
				26: Q=21;
			 	42: Q=34;
				68: Q=55;
				110: Q=0;
			endcase	
		end
		else if (PorF==1 && UorD==1) begin
			if (Q!=1)
				flag=0;
			case ({Q,flag})
				0: Q=55;
				2: Q=0;
				3: flag=0;
				4: begin   // control about state 1 apper 2 times
					Q=1;
					flag=1;
				   end	
				6: Q=2;
				10: Q=3;
				16: Q=5;
				26: Q=8;
				42: Q=13;
				68: Q=21;
				110: Q=34;
			endcase 
		end
	end 
	
endmodule

module testanlyser (clk,Q,Q1);
	input clk;
	input [6:1]Q,Q1 ;
	
	always @(posedge clk) begin
		$write("%d    RealResult= %d  ExpectedResult= %d   ",$time,Q1,Q); // print results
		if (Q==Q1)	  // if expected result equal real result print true
			$display("True");
		else
			$display("False");	
	end
	
endmodule

module testbench ;
	
	wire clk ,PorF,UorD ,reset , enable;
	wire [6:1]Q ,Q1;
	
	// Generate vector tese
	testGenerater t(clk ,PorF,UorD ,reset , enable,Q);
	
	// find real result
	counter t1(clk ,PorF,UorD ,reset , enable,Q1);
	
	// go to compare
	testanlyser t2(clk,Q , Q1);
	
endmodule 