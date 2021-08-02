module Tx_LAB5_DRF(Clk,Send,PDin,SCout,SDout);  //Tx
	input Clk;
	input Send;   
	input [7:0] PDin;							// Paralel data
	output SCout;
	output SDout;

	reg [7:0] SRreg;							// Shift register to store 8-bit parallel data
	reg Serial_out;								// Transmission condition
	reg r_Send;									
	reg ParErr;
	
	wire Send_1clk;
	
	always @(posedge Clk)
		begin
			r_Send <= Send;
			ParErr <= ^PDin[7:0];	// parity bit
		end
		
	assign Send_1clk = ~r_Send & Send;	

always @(posedge Clk)
        begin
            if (Send_1clk)
                begin
                    Serial_out <= 1'b1;            // starting condition
                    SRreg [7:0] <= PDin [7:0];    // Storing data
                end
            else                                  // Paralel to Serial transmission
                begin
                    Serial_out <= SRreg[7];        // MSB
                    SRreg[7:1] <= SRreg[6:0];    // shifting
                    SRreg[0] <= ParErr;            // clear LSB
                end
        end
 
	assign SCout = Clk; 						
	assign SDout = Serial_out; 					//Transmitting to Serial data 
 
endmodule

