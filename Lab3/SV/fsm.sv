module FSM (clk, reset, l, r, y, ledOut);

  input logic clk;
  input logic reset;
  input logic l;
  input logic r;
   
  output logic [1:0] y;
  output logic [5:0] ledOut;

  typedef enum logic [3:0] {IDLE, LEFT1, LEFT2, LEFT3, RIGHT1, RIGHT2, RIGHT3, BOTH1, BOTH2, BOTH3} statetype;
  statetype state, nextstate;

  logic clk_en;

  clk_div clkDiv(clk, reset, clk_en);
   
   // state register
  always_ff @(posedge clk, posedge reset)
    if (reset) state <= IDLE;
    else state <= nextstate;
   
   // next state logic
  always_comb
    case (state)
      IDLE: begin
	      y = 2'b0;
        ledOut[5:0] = 6'b0;
	      if(l & r) nextstate <= BOTH1;
        else if(l) nextstate <= LEFT1;
        else if(r) nextstate <= RIGHT1;
	      else nextstate <= IDLE;
      end
      LEFT1: begin
	      y = 2'b01;
	      ledOut[2] = 1'b1;
        nextstate <= LEFT2;
      end
      LEFT2: begin
        y = 2'b01;
        ledOut[1] = 1'b1;
        nextstate <= LEFT3;
      end
      LEFT3: begin
        y = 2'b01;
        ledOut[0] = 1'b1;
        nextstate <= IDLE;
      end
      RIGHT1: begin
	      y = 2'b10;
        ledOut[3] = 1'b1;
        nextstate <= RIGHT2;
      end
      RIGHT2: begin
	      y = 2'b10;
        ledOut[4] = 1'b1;
        nextstate <= RIGHT3;
      end
      RIGHT3: begin
	      y = 2'b10;
        ledOut[5] = 1'b1;
        nextstate <= IDLE;
      end
      BOTH1: begin
        y = 2'b11;
        ledOut[2] = 1'b1;
        ledOut[3] = 1'b1;
        nextstate <= BOTH2;
      end
      BOTH2: begin
        y = 2'b11;
        ledOut[1] = 1'b1;
        ledOut[4] = 1'b1;
        nextstate <= BOTH3;
      end
      BOTH3: begin
        y = 2'b11;
        ledOut[0] = 1'b1;
        ledOut[5] = 1'b1;
        nextstate <= IDLE;
      end
      default: begin
	      y = 1'b0;	  	  
	      nextstate <= IDLE;
      end
    endcase
   
endmodule

module blink();
  
endmodule
