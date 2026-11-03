`timescale 1ns / 1ps



module tb();

reg sys_clk,reset,start;
reg [11:0] din;

wire [11:0] rx;
wire cs,mosi,done;
wire sclk;


top dut (.sys_clk(sys_clk), .reset(reset), .start (start), .din(din), .rx(rx), .cs(cs), 
            .mosi(mosi), .done(done),.sclk(sclk));
            
 initial begin
  sys_clk = 0;
  din = 0;
  end     
  
  always #10 sys_clk = ~ sys_clk;
  
  initial 
  begin
  
  reset = 1;
  start = 0;
  #20;
  reset = 0;
 
  start = 1;
  
  din =  420;
  @(posedge done);
   #20;
  start = 0;
   #500;
   $stop;
  
  end      
       

endmodule
