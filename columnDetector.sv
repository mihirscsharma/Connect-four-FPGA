// The purpose of the columnDetector module is to determine which column a player wants to 
// drop their token into based on the input from a set of switches. 

module columnDetector (
    input reset,                  // Reset input
    input logic [7:0] sw,         // 8-bit switch input
    output logic [3:0] column     // Column to place the next token
);

    //If a particular switch is active, column is set to a corresponding value
	 
	 always_comb begin
        case (sw)
            8'b00000001: column = 4'b0001;   // SW[1]
            8'b00000010: column = 4'b0010;   // SW[2]
            8'b00000100: column = 4'b0011;   // SW[3]
            8'b00001000: column = 4'b0100;   // SW[4]
            8'b00010000: column = 4'b0101;   // SW[5]
            8'b00100000: column = 4'b0110;   // SW[6]
            8'b01000000: column = 4'b0111;   // SW[7]
            8'b10000000: column = 4'b1000;   // SW[8]
            default: column = 4'b0000;       // Default case: no switch or multiple switches
        endcase
        
        if (reset) 
            column = 4'b0000;                // Reset condition: set column to 0
    end

endmodule

module columnDetector_testbench();
    // Define the signals
    logic reset;
    logic [7:0] sw;
    logic [3:0] column;
    
    // Instantiate the DUT (Device Under Test)
    columnDetector dut (
        .reset(reset),
        .sw(sw),
        .column(column)
    );

    // Try all combinations of inputs
    integer i;
    initial begin
        // Test with reset deactivated
        reset = 0;
        for (i = 0; i < 256; i++) begin
            sw = i;
            #10;
        end
        
        // Test reset functionality
        reset = 1; #10; // Activate reset
        reset = 0; #10; // Deactivate reset
        
        // Test again with reset deactivated
        for (i = 0; i < 256; i++) begin
            sw = i;
            #10;
        end

        $stop; // End simulation
    end
endmodule
