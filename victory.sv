// The victory module is designed to determine the winner in a Connect Four game 
// by checking the game board for four consecutive tokens of the same color 
// (either red or green) in horizontal, vertical, and diagonal directions. 
// If a win condition is detected, it outputs a specific code to the winner signal to indicate which player has won.


// Green Player Wins: When the winner output is set to 7'b1111001, the 7-segment display shows the digit 1
// Red Player Wins: When the winner output is set to 7'b0100100, the 7-segment display shows the digit 2 

module victory (
    input logic [15:0][15:0] red, grn, // 16x16 arrays for red and green pixels
    input logic [4:0] newrow,          // New row index
    input logic [4:0] newcolumn,       // New column index
    input logic reset,                 // Reset input
    output logic [6:0] winner          // Winner output (7-segment display code)
);

    // Combinational logic to determine the winner
    always_comb begin
        if (reset) begin
            winner = 7'b1111111; // Default value for reset state
        end else begin
            // Check for horizontal win for green
            if ((grn[newrow][newcolumn] & grn[newrow][newcolumn + 1] & grn[newrow][newcolumn + 2] & grn[newrow][newcolumn + 3]) ||
                (grn[newrow][newcolumn] & grn[newrow][newcolumn - 1] & grn[newrow][newcolumn - 2] & grn[newrow][newcolumn - 3])) begin
                winner = 7'b1111001; // Green wins
            end
            // Check for vertical win for green
            else if ((newrow <= 12) &&
                (grn[newrow][newcolumn] & grn[newrow + 1][newcolumn] & grn[newrow + 2][newcolumn] & grn[newrow + 3][newcolumn])) begin
                winner = 7'b1111001; // Green wins
            end
            // Check for diagonal win for green
            else if ((grn[newrow][newcolumn] & grn[newrow + 1][newcolumn + 1] & grn[newrow + 2][newcolumn + 2] & grn[newrow + 3][newcolumn + 3]) ||
                     (grn[newrow][newcolumn] & grn[newrow + 1][newcolumn - 1] & grn[newrow + 2][newcolumn - 2] & grn[newrow + 3][newcolumn - 3]) ||
                     (grn[newrow][newcolumn] & grn[newrow - 1][newcolumn - 1] & grn[newrow - 2][newcolumn - 2] & grn[newrow - 3][newcolumn - 3]) ||
                     (grn[newrow][newcolumn] & grn[newrow - 1][newcolumn + 1] & grn[newrow - 2][newcolumn + 2] & grn[newrow - 3][newcolumn + 3])) begin
                winner = 7'b1111001; // Green wins
            end
            // Check for horizontal win for red
            else if ((red[newrow][newcolumn] & red[newrow][newcolumn + 1] & red[newrow][newcolumn + 2] & red[newrow][newcolumn + 3]) ||
                     (red[newrow][newcolumn] & red[newrow][newcolumn - 1] & red[newrow][newcolumn - 2] & red[newrow][newcolumn - 3])) begin
                winner = 7'b0100100; // Red wins
            end
            // Check for vertical win for red
            else if ((newrow <= 12) &&
                (red[newrow][newcolumn] & red[newrow + 1][newcolumn] & red[newrow + 2][newcolumn] & red[newrow + 3][newcolumn])) begin
                winner = 7'b0100100; // Red wins
            end
            // Check for diagonal win for red
            else if ((red[newrow][newcolumn] & red[newrow + 1][newcolumn + 1] & red[newrow + 2][newcolumn + 2] & red[newrow + 3][newcolumn + 3]) ||
                     (red[newrow][newcolumn] & red[newrow + 1][newcolumn - 1] & red[newrow + 2][newcolumn - 2] & red[newrow + 3][newcolumn - 3]) ||
                     (red[newrow][newcolumn] & red[newrow - 1][newcolumn + 1] & red[newrow - 2][newcolumn + 2] & red[newrow - 3][newcolumn + 3]) ||
                     (red[newrow][newcolumn] & red[newrow - 1][newcolumn - 1] & red[newrow - 2][newcolumn - 2] & red[newrow - 3][newcolumn - 3])) begin
                winner = 7'b0100100; // Red wins
            end
            // No winner
            else begin
                winner = 7'b1111111; // No win condition met
            end
        end
    end

endmodule

module victory_testbench();
    // Testbench signals
    logic [15:0][15:0] red, grn;
    logic [4:0] newrow, newcolumn;
    logic reset;
    logic [6:0] winner;

    // Instantiate the DUT (Device Under Test)
    victory dut (
        .red(red),
        .grn(grn),
        .newrow(newrow),
        .newcolumn(newcolumn),
        .reset(reset),
        .winner(winner)
    );

    // Stimulus process
    initial begin
        // Initialize signals
        red = '0;
        grn = '0;
        newrow = 0;
        newcolumn = 0;
        reset = 1;
        #10;

        // Release reset
        reset = 0;

        // Test horizontal win for green
        grn[0][0] = 1; grn[0][1] = 1; grn[0][2] = 1; grn[0][3] = 1;
        newrow = 0; newcolumn = 3; #10;

        // Test vertical win for green
        grn[0][0] = 1; grn[1][0] = 1; grn[2][0] = 1; grn[3][0] = 1;
        newrow = 3; newcolumn = 0; #10;

        // Test diagonal win for green
        grn[0][0] = 1; grn[1][1] = 1; grn[2][2] = 1; grn[3][3] = 1;
        newrow = 3; newcolumn = 3; #10;

        // Test horizontal win for red
        red[0][0] = 1; red[0][1] = 1; red[0][2] = 1; red[0][3] = 1;
        newrow = 0; newcolumn = 3; #10;

        // Test vertical win for red
        red[0][0] = 1; red[1][0] = 1; red[2][0] = 1; red[3][0] = 1;
        newrow = 3; newcolumn = 0; #10;

        // Test diagonal win for red
        red[0][0] = 1; red[1][1] = 1; red[2][2] = 1; red[3][3] = 1;
        newrow = 3; newcolumn = 3; #10;

        // Apply reset during operation
        reset = 1; #10;
        reset = 0; #10;

        // End simulation
        $stop;
    end
endmodule

