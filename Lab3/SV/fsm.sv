module FSM (clk, reset, l, r, currentState, ledOut);

  input logic clk;
  input logic reset;
  input logic l;
  input logic r;
   
  output logic [3:0] currentState;
  output logic [5:0] ledOut;

  typedef enum logic [3:0] {IDLE, LEFT1, LEFT2, LEFT3, RIGHT1, RIGHT2, RIGHT3, BOTH1, BOTH2, BOTH3} statetype;
  statetype state, nextstate;

  logic clk_en;
   
   // state register
  always_ff @(posedge clk, posedge reset)
    if (reset) state <= IDLE;
    else state <= nextstate;
   
   // next state logic
  always_comb
    case (state)
      IDLE: begin
	      currentState = 4'b0;
        ledOut[5:0] = 6'b0;
	      if(l & r) nextstate <= BOTH1;
        else if(l) nextstate <= LEFT1;
        else if(r) nextstate <= RIGHT1;
	      else nextstate <= IDLE;
      end
      LEFT1: begin
	      currentState = 4'b0001;
        ledOut[3] = 1'b1;
        nextstate <= LEFT2;
      end
      LEFT2: begin
        currentState = 4'b0010;
        ledOut[4:3] = 2'b11;
        nextstate <= LEFT3;
      end
      LEFT3: begin
        currentState = 4'b0011;
        ledOut[5:3] = 3'b111;
        nextstate <= IDLE;
      end
      RIGHT1: begin
	      currentState = 4'b0100;
        ledOut[2] = 1'b1;
        nextstate <= RIGHT2;
      end
      RIGHT2: begin
	      currentState = 4'b0101;
        ledOut[2:1] = 2'b11;
        nextstate <= RIGHT3;
      end
      RIGHT3: begin
	      currentState = 4'b0110;
        ledOut[2:0] = 3'b111;
        nextstate <= IDLE;
      end
      BOTH1: begin
        currentState = 4'b0111;
        ledOut[2] = 1'b1;
        ledOut[3] = 1'b1;
        nextstate <= BOTH2;
      end
      BOTH2: begin
        currentState = 4'b1000;
        ledOut[2:1] = 2'b11;
        ledOut[4:3] = 2'b11;
        nextstate <= BOTH3;
      end
      BOTH3: begin
        currentState = 4'b1001;
        ledOut[2:0] = 3'b111;
        ledOut[5:3] = 3'b111;
        nextstate <= IDLE;
      end
      default: begin
	      currentState = 4'b0;	  	  
	      nextstate <= IDLE;
      end
    endcase
   
endmodule

module blink();
  
endmodule
