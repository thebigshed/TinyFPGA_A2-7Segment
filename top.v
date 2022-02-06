module LED_7seg(clk, segA, segB, segC, segD, segE, segF, segG, segDP);
inout clk;
output segA, segB, segC, segD, segE, segF, segG, segDP;
OSCH #(.NOM_FREQ("16.63")) rc_oscillator(.STDBY(1'b0), .OSC(clk));
reg [3:0] BCD;
initial
begin
	BCD = 4'h5;
	end

// cnt is used as a prescaler
reg [23:0] cnt;
always @(posedge clk) cnt<=cnt+24'h1;
wire cntovf = &cnt;

// BCD is a counter that counts from 0 to 9

always @(posedge clk) if(cntovf) BCD <= (BCD==4'h9 ? 4'h0 : BCD+4'h1);

reg [7:0] SevenSeg;
always @(*)
case(BCD)
    4'h0: SevenSeg = 8'b11111100;
    4'h1: SevenSeg = 8'b01100000;
    4'h2: SevenSeg = 8'b11011010;
    4'h3: SevenSeg = 8'b11110010;
    4'h4: SevenSeg = 8'b01100110;
    4'h5: SevenSeg = 8'b10110110;
    4'h6: SevenSeg = 8'b10111110;
    4'h7: SevenSeg = 8'b11100000;
    4'h8: SevenSeg = 8'b11111110;
    4'h9: SevenSeg = 8'b11110110;
    default: SevenSeg = 8'b00000000;
endcase

assign {segA, segB, segC, segD, segE, segF, segG, segDP} = SevenSeg;
endmodule