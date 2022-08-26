// Four-bit universal shift register
module uni_shift_reg (
  input s0, s1,
        MSB_in, LSB_in,
        clr, CLK;
  input [3:0] reg_in;
  output [3:0] reg_out;
  
  always (posedge CLK, negedge clr)
    begin
      if (!clr) reg_out <= 4b'00000;
    else
      case({s1, s0})
        2'b00: reg_out <= reg_out ;// no change
        2'b01: reg_out <= {MSB, reg_out[3:1]}; // right shift
        2'b10: reg_out <= {reg_out[2:0], LSB};// left shift 
        2'b11:  reg_out <= reg_in; // load input
      endcase
    end
);
  
endmodule 
//-----------------------------------------
// Four-bit binary counter
module binary_counter(
  input CLK, Clr, Load, Count;
  input [3:0] C_in;
  output C_cout;    // Carry output
  output [3:0] count_out);
  
  assign C_out = Count && !Clr && Count && (C_out==4'b1111);
  
  always @(posedge CLK, negedge Clr)
    begin
      if(!Clr) count_out <= 4'b0000;
      else if (Load) count_out <= C_in;
      else if (Count) count_out <= C_in + 1'b1;
    end   
endmodule 

//----------------------------------
// Memory Reads & Write
// Memr of size 64, 8 bit length 
// Address is 6 bits long (64 = 2^6)
module memory(
  input CLK, En, ReadWrite;
  input [7:0] Data_in;
  inout [5:0] Addr;
  output [7:0] Data_out
);
  reg [7:0]  Memr [63:0]  // [length] Mem [depth]
  always @(posedge CLK, ReadWrite, En)
    begin
      if (!En) Data_out = 8'bz;   // High impedance state
       else
         if (ReadWrite) Data_out = Memr[Addr]; // Read operation 
            else  Memr[Addr] = Data_in // Write operation 
    end 
endmodule 
