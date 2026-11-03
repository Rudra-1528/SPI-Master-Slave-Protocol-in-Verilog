`timescale 1ns / 1ps


module top #(parameter sys_clk_F = 50_000_000,
             parameter sclk_F = 1000_000,
             parameter D_w = 12)
(
input sys_clk,reset,start,
input [D_w-1:0] din ,       ///// data_tx
output reg [D_w -1 : 0] rx,          ///// data_rx
output reg cs, mosi,done,
output reg sclk
    );
    
 parameter t_count = (sys_clk_F /( 2*sclk_F) );
 
 integer count = 0;
 
 parameter idle =0, start_tx=1, send = 2, end_tx = 3;
 reg [1:0] state = idle ;
 
 always @ (posedge sys_clk)
 begin
    if (reset)
      begin
        state <= idle;
        sclk <= 0;
        mosi <= 0;
        cs <= 1;
        rx <= 0;
        done <= 0;
       end
       
      else 
         begin
           if ( count < t_count)
              count <= count +1;
            else
              begin
               sclk <= ~sclk;
               count <= 0;
             end   
               
          end 
   end
   
   
   /////////////////////////// data sending 
 

 reg [D_w-1: 0] temp, temp_rx = 0;
 integer bit_count =0;
 
 always @ (posedge sclk)
 begin 
   case (state)
     idle : begin
        cs <= 1;
        mosi <= 0;
        done <=0;
        
        if ( start)
             state <= start_tx;
         else
            state <= idle;
        
       end  
       
       start_tx : begin
           cs <= 0;
           temp <= din; 
           state <= send ;
        end 
        
        send : begin
            if ( bit_count <= (D_w-1) )
             begin 
                mosi <= temp [bit_count]; 
                state <= send ;
                temp_rx <= {mosi, temp_rx[D_w-1: 1]};
                bit_count <= bit_count +1;
             end 
             
             else  
                begin
                   temp_rx <= {mosi, temp_rx[D_w-1: 1]};
                   state <= end_tx; 
                   bit_count <= 0;
                   mosi <= 0;
                 end
           end 
           
           end_tx :
             begin 
                state <= idle;
                done <=1;
                cs <= 1;
             end 
             
          default : begin 
            state <= idle;
          end   
       
       endcase 
         
          rx <= temp_rx;
          
      end                
                       
    
endmodule
