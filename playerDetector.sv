//The playerDetector module is designed to alternate between two players in a Connect Four game. 
// It keeps track of whose turn it is to place a token and updates the current player based on the game state.
// This module ensures that players take turns and correctly handles situations where a column is full or an invalid column is selected.

module playerDetector (
    input logic [7:0][2:0] counters, // 8x3 array representing the counters for each column
    input logic reset, clk,          // Reset and clock inputs
    input logic [3:0] column,        // Column input
    output player                    // Output: 0 = player 1, 1 = player 2
);

    // Define states for player turns
    enum logic {P1 = 1'b0, P2 = 1'b1} ps, ns;

    // Combinational logic to determine next state
    always_comb begin
        case(ps)
            P1: begin
                if ((counters[0] == 6 && column == 1) || (counters[1] == 6 && column == 2) ||
                    (counters[2] == 6 && column == 3) || (counters[3] == 6 && column == 4) ||
                    (counters[4] == 6 && column == 5) || (counters[5] == 6 && column == 6) ||
                    (counters[6] == 6 && column == 7) || (counters[7] == 6 && column == 8) ||
                    column == 0)
                    ns = P1; // Stay in P1 if column is full or invalid
                else
                    ns = P2; // Switch to P2 otherwise
            end
            P2: begin
                if ((counters[0] == 6 && column == 1) || (counters[1] == 6 && column == 2) ||
                    (counters[2] == 6 && column == 3) || (counters[3] == 6 && column == 4) ||
                    (counters[4] == 6 && column == 5) || (counters[5] == 6 && column == 6) ||
                    (counters[6] == 6 && column == 7) || (counters[7] == 6 && column == 8) ||
                    column == 0)
                    ns = P2; // Stay in P2 if column is full or invalid
                else
                    ns = P1; // Switch to P1 otherwise
            end
        endcase
    end

    // Sequential logic to update current state
    always_ff @(posedge clk) begin
        if (reset)
            ps <= P1;  // Reset to player 1's turn
        else
            ps <= ns;  // Update to next state
    end
    
    // Assign current state to player output
    assign player = ps;

endmodule

module playerDetector_testbench();
    // Testbench signals
    logic [7:0][2:0] counters;
    logic reset;
    logic clk;
    logic [3:0] column;
    logic player;

    // Instantiate the DUT (Device Under Test)
    playerDetector dut (
        .counters(counters),
        .reset(reset),
        .clk(clk),
        .column(column),
        .player(player)
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
        column = 0;
        counters = '{default: 3'b000};

        // Apply reset
        #10 reset = 0;

        // Test player turns with various column selections
        column = 1; #10;
        column = 2; #10;
        column = 3; #10;
        column = 4; #10;

        // Test with a full column
        counters[1] = 6;  // Column 2 is full
        column = 2; #10;
        column = 3; #10;
        column = 2; #10;

        // Apply and release reset during operation
        reset = 1; #10;
        reset = 0; #10;

        // Test turns after reset
        column = 1; #10;
        column = 2; #10;

        // Test with no column selected
        column = 0; #10;
        column = 3; #10;

        // End simulation
        $stop;
    end
endmodule
