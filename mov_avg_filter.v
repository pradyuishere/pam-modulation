module moving_avg_filt(
  input clk,
  input signed [7:0] signal_in,
  output reg signed [7:0] signal_out
  );

  parameter N = 64; //**must be a power of 2

  reg signed [7:0] input_signal_queue [0:N-1];
  reg signed [13:0] signal_in_sum;
  integer iter;

  always @ (posedge clk) begin
    input_signal_queue[0] <= signal_in;
    for (iter = 0; iter < N - 1; iter = iter + 1)
    begin
      input_signal_queue[iter + 1] <= input_signal_queue[iter];
    end // end for
  end

  always@(posedge clk) begin
    for (iter = 0; iter < N; iter = iter + 1) begin
      signal_in_sum = signal_in_sum + input_signal_queue[iter];
    end
    signal_out = signal_in_sum >>> 6;
  end //end always posedge clk

  always@(negedge clk) begin
    signal_in_sum = 0;
  end
endmodule
