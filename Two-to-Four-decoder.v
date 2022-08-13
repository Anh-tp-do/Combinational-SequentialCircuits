module decoder (
 input I0, I1, En,
 output [3:0] D
 );
 
 assign D[0] = !I0 && !I1 && !En;
 assign D[1] = I0 && !I1 && !En;
 assign D[2] = !I0 && I1 && !En;
 assign D[3] = I0 && I1 && !En;

endmodule
