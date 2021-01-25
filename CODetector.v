`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:52:21 01/25/2021 
// Design Name: 
// Module Name:    CODetector 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CODetector(
	input    	arst, // async reset
	input    	clk , // clock posedge
	input    	din , // input data 
	output		dout  // output data of detector
);
	// DFFs outputs / inputs
	wire Q3, Q2, Q1, Q0, Q3P, Q2P, Q1P, Q0P, dinP;
	wire I0, I1, I2, I3;
	
	not
		q3p (Q3P, Q3),
		q2p (Q2P, Q2),
		q1p (Q1P, Q1),
		q0p (Q0P, Q0),
		dinp (dinP, din);
		
	DFF
		dff_0 (arst, clk, I0, Q0),
		dff_1 (arst, clk, I1, Q1),
		dff_2 (arst, clk, I2, Q2),
		dff_3 (arst, clk, I3, Q3);
	
	
	// DFF input functions
	
	// Q3
	wire middleQ3_1, middleQ3_2, middleQ3_3;
	and
		middleQ3_part1 (middleQ3_1, Q3, Q2P, Q1P, dinP),
		middleQ3_part2 (middleQ3_2, Q3, Q2P, Q1, din),
		middleQ3_part3 (middleQ3_3, Q3P, Q2, Q1, Q0, din);
	or Q3_input_result (I3, middleQ3_1, middleQ3_2, middleQ3_3);
	
	// Q2
	wire middleQ2_1, middleQ2_2, middleQ2_3, middleQ2_4, middleQ2_5;
	and
		middleQ2_part1 (middleQ2_1, Q3P, Q2, Q1P, Q0, dinP),
		middleQ2_part2 (middleQ2_2, Q3P, Q2P, Q1, Q0, dinP),
		middleQ2_part3 (middleQ2_3, Q3P, Q2, Q1, Q0P, dinP),
		middleQ2_part4 (middleQ2_4, Q3P, Q2, Q1P, Q0P, din),
		middleQ2_part5 (middleQ2_5, Q3, Q2P, Q1, Q0, din);
	or Q2_input_result (I2, middleQ2_1, middleQ2_2, middleQ2_3, middleQ2_4, middleQ2_5);
	
	// Q1
	wire middleQ1_1, middleQ1_2, middleQ1_3, middleQ1_4;
	and
		middleQ1_part1 (middleQ1_1, Q3P, Q1P, Q0, din),
		middleQ1_part2 (middleQ1_2, Q2P, Q1P, Q0, din),
		middleQ1_part3 (middleQ1_3, Q3P, Q2, Q1, Q0P, dinP),
		middleQ1_part4 (middleQ1_4, Q2P, Q1, Q0P, din);
	or Q1_input_result (I1, middleQ1_1, middleQ1_2, middleQ1_3, middleQ1_4);	
	
	//Q0
	wire middleQ0_1, middleQ0_2, middleQ0_3, middleQ0_4, middleQ0_5, middleQ0_6;
	and
		middleQ0_part1 (middleQ0_1, Q1P, din),
		middleQ0_part2 (middleQ0_2, Q0P, din),
		middleQ0_part3 (middleQ0_3, Q3P, Q2P, din),
		middleQ0_part4 (middleQ0_4, Q3, Q2, din),
		middleQ0_part5 (middleQ0_5, Q3, Q2P, Q1P, Q0P),
		middleQ0_part6 (middleQ0_6, Q3P, Q2, Q1, Q0P);
	or Q0_input_result (I0, middleQ0_1, middleQ0_2, middleQ0_3, middleQ0_4, middleQ0_5, middleQ0_6);
	
	
	// Output
	and result (dout, Q3, Q2, Q1P, Q0P);
	
endmodule
