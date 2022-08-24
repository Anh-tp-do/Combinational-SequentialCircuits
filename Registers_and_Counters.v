// four-bit universal shift register
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
//-------------------------
