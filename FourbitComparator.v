module fourbitcomparator(
  input [3:0] A, B,
  output lt, gt, eq
);
  assign lt = A < B;
  assign gt = A > B;
  assign eq = A==B;
endmodule 
