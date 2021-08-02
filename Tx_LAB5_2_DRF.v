module Tx_LAB5_2_DRF(Clk,Send,PDin,SCout,SDout);  //Tx
	input Clk;
	input Send;   
	input [7:0] PDin;							// Paralel data
	output SCout;
	output SDout;

	reg [7:0] SRreg;							// Shift register to store 8-bit parallel data
	reg Serial_out;								// Transmission condition
	
	reg Sout;
	reg EPout;
	
	
	always @(posedge Send or posedge EPout)
	begin	
		if (EPout)
			Sout <= 1'b0;
		else
			Sout <= 1'b1;
	end
	
	always @(posedge Clk)
	begin
		EPout <= Sout;
	end

		
	
	
always @(posedge Clk)
        begin
            if (EPout)
                begin
                    Serial_out <= 1'b1;            // starting condition
                    SRreg [7:0] <= PDin [7:0];    // Storing data
                end
            else                                  // Paralel to Serial transmission
                begin
                    Serial_out <= SRreg[7];        // MSB
                    SRreg[7:1] <= SRreg[6:0];    // shifting
                    SRreg[0] <= 1'b0;            // clear LSB
                end
        end
        
        
        
	/// HOCAM RAPORLUYDUM UNUTURSAM DIYE HATIRLATMA COMMENTI
	assign SCout = Clk; 						
	assign SDout = Serial_out; 					//Transmitting to Serial data 
 
endmodule

