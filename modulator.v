module pam_mixer(
  input clk,
  input [1:0] data_in,
  input signed [7:0] sin_in,
  output signed [7:0] signal_out
);
  wire signed [2:0] signed_data_in;
  wire signed [10:0] temp_storage;
  //
  // always@(*)
  // begin
  //   temp_storage = sin_in*
  // end
  assign signed_data_in = data_in;
  assign temp_storage = sin_in*signed_data_in;
  assign signal_out = temp_storage>>>1;

endmodule
