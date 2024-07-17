// It integrates several sub-modules to handle various aspects of the game, 
// such as user input, column selection, player switching, display updates, 
// game board management, and victory detection.

module connectFour (
    input logic clk, reset,                  // Clock and reset inputs
    input logic [7:0] sw,                    // 8-bit input switch
    output logic [6:0] player_7seg,          // 7-segment display for player indicator (HEX0)
    output logic [6:0] winner,               // 7-segment display for winner indicator (HEX5)
    output logic [15:0][15:0] RedPixels,     // 16x16 array for red pixels
    output logic [15:0][15:0] GrnPixels      // 16x16 array for green pixels
);

    logic [7:0] sw_sync;                     // Synchronized switch input (after edge detection)
    logic [3:0] column;                      // Column to place the new token
    logic player;                            // Player indicator (0 for player 1, 1 for player 2)
    logic [7:0][2:0] counters;               // 8x3 2-D array representing 8 counters, each with a 3-bit count
    logic [15:0][15:0] red, green;           // 16x16 2-D arrays for red and green pixels
    logic [4:0] prevtokenrow;                // Row index of the newly placed token
    logic [4:0] prevtokencolumn;             // Column index of the newly placed token

    // User input module to synchronize switch input
    userInput u(
        .sw_sync(sw_sync), 
        .clk(clk), 
        .reset(reset), 
        .sw(sw)
    );

    // Column indicator module to determine the column for the new token
    columnDetector cln(
        .column(column), 
        .reset(reset), 
        .sw(sw_sync)
    );

    // Player indicator module to switch between players
    playerDetector plr(
        .player(player), 
        .clk(clk), 
        .reset(reset), 
        .column(column), 
        .counters(counters)
    );

    // 7-segment display module to show the current player
    seg7 seg(
        .bcd({2'b00, player} + 1), 
        .leds(player_7seg)
    );

    // gameBoard module to manage token placement and pixel updates
    gameBoard field(
        .prevtokenrow(prevtokenrow), 
        .prevtokencolumn(prevtokencolumn), 
        .counters(counters), 
        .redpixels(red), 
        .grnpixels(green), 
        .clk(clk), 
        .reset(reset), 
        .player(player), 
        .inputcolumn(column)
    );

    // Victory module to determine the winner
    victory v(
        .winner(winner), 
        .reset(reset), 
        .red(red), 
        .grn(green), 
        .newrow(prevtokenrow), 
        .newcolumn(prevtokencolumn)
    );

    // Assigning the internal red and green pixel arrays to the output
    assign RedPixels = red;
    assign GrnPixels = green;

endmodule

module connectFour_testbench();
    // Testbench signals
    logic clk, reset;
    logic [7:0] sw;
    logic [6:0] player_7seg;
    logic [6:0] winner;
    logic [15:0][15:0] RedPixels, GrnPixels;

    // Instantiate the DUT (Device Under Test)
    connectFour dut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .player_7seg(player_7seg),
        .winner(winner),
        .RedPixels(RedPixels),
        .GrnPixels(GrnPixels)
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
        sw = 8'b00000000;

        // Apply reset
        #10 reset = 0;  // Release reset

        // Test each switch input to simulate token placement
        sw = 8'b00000001; #20;  // Place token in column 1
        sw = 8'b00000010; #20;  // Place token in column 2
        sw = 8'b00000100; #20;  // Place token in column 3
        sw = 8'b00001000; #20;  // Place token in column 4
        sw = 8'b00010000; #20;  // Place token in column 5
        sw = 8'b00100000; #20;  // Place token in column 6
        sw = 8'b01000000; #20;  // Place token in column 7
        sw = 8'b10000000; #20;  // Place token in column 8

        // Apply reset to verify reset functionality
        reset = 1; #10;
        reset = 0; #10;

        // Test again with reset deactivated to check for normal operation
        sw = 8'b00000001; #20;
        sw = 8'b00000010; #20;
        sw = 8'b00000100; #20;
        sw = 8'b00001000; #20;
        sw = 8'b00010000; #20;
        sw = 8'b00100000; #20;
        sw = 8'b01000000; #20;
        sw = 8'b10000000; #20;

        // End simulation
        $stop;
    end
endmodule

