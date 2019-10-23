module qam_demodulator(
  input clk,
  input signed [7:0] input_signal,
  output reg [1:0] data_demod
  );
  reg signed [7:0] mod_value;

  wire signed [7:0] avg_filt_out;

  moving_avg_filt mov_avg(
    clk,
    mod_value,
    avg_filt_out
    );

  always @ ( posedge clk ) begin
    mod_value = input_signal;
    if (input_signal < 0) begin
      mod_value = 255 - input_signal;
    end
  end

  always @ ( * ) begin
    if (avg_filt_out <= 9) data_demod = 0;
    else if (avg_filt_out <= 28) data_demod = 1;
    else if (avg_filt_out <= 47) data_demod = 2;
    else data_demod = 3;
  end

endmodule
