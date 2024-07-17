// The rowCounter module is designed to count the number of tokens placed in a
// specific column of a Connect Four game. This module helps keep track of how 
// many tokens are in each column, which is crucial for managing the game state 
//and determining valid moves. Each column has its own rowCounter instance.


module rowCounter(
    input logic clk, reset,              // Clock and reset inputs
    input logic [3:0] inputcolumn,       // Input column
    input logic [3:0] thiscolumn,        // This column
    output logic [2:0] count             // 3-bit count output
);

    // Sequential logic to update count
    always_ff @(posedge clk) begin
        if (reset)
            count <= 3'b000;             // Reset count to 0
        else if (count == 6)
            count <= 6;                  // Keep count at 6 if it reaches 6
        else if (inputcolumn == thiscolumn)
            count <= count + 1;          // Increment count if input column matches this column
        else 
            count <= count;              // Otherwise, retain current count
    end

endmodule

module rowCounter_testbench();
    // Testbench signals
    logic clk;
    logic reset;
    logic [3:0] inputcolumn;
    logic [3:0] thiscolumn;
    logic [2:0] count;

    // Instantiate the DUT (Device Under Test)
    rowCounter dut (
        .clk(clk),
        .reset(reset),
        .inputcolumn(inputcolumn),
        .thiscolumn(thiscolumn),
        .count(count)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 10-time units period clock
    end

    // Stimulus process
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        inputcolumn = 0;
        thiscolumn = 1;
        #10;

        // Release reset
        reset = 0;

        // Test counting for the correct column
        inputcolumn = 1;
        repeat (8) begin
            #10;  // Wait for a few clock cycles
        end

        // Test counting stops at 6
        inputcolumn = 1;
        #80;  // Wait for enough cycles to ensure count stops at 6

        // Apply and release reset
        reset = 1; #10;
        reset = 0; #10;

        // Test counting for a different column
        thiscolumn = 2;
        inputcolumn = 2;
        repeat (8) begin
            #10;  // Wait for a few clock cycles
        end

        // End simulation
        $stop;
    end
endmodule
