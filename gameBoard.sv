//It manages the game board's state, handles token placement, and updates the visual representation of the game.

module gameBoard (
    input logic clk, reset, player,         // Clock, reset, and player inputs
    input logic [3:0] inputcolumn,          // Input column
    output logic [15:0][15:0] redpixels,    // 16x16 array for red pixels
    output logic [15:0][15:0] grnpixels,    // 16x16 array for green pixels
    output logic [7:0][2:0] counters,       // 8x3 array for counters
    output logic [4:0] prevtokenrow,        // Previous token row
    output logic [4:0] prevtokencolumn      // Previous token column
);

    logic [15:0][15:0] red, green;          // Temporary 16x16 arrays for red and green pixels
    logic [2:0] row;                        // Row logic
    logic [4:0] column;                     // Column logic

    // Initialize the red and green pixel arrays to zero
    initial begin
        red = '0;
        green = '0;
    end

    // Each rowCounter module tracks the number of tokens in a specific column.
	 // The counter increments each time a token is placed in its corresponding column.
    rowCounter column1(.count(counters[0]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(1));
    rowCounter column2(.count(counters[1]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(2));
    rowCounter column3(.count(counters[2]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(3));
    rowCounter column4(.count(counters[3]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(4));
    rowCounter column5(.count(counters[4]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(5));
    rowCounter column6(.count(counters[5]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(6));
    rowCounter column7(.count(counters[6]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(7));
    rowCounter column8(.count(counters[7]), .clk(clk), .reset(reset), .inputcolumn(inputcolumn), .thiscolumn(8));

    //The ledController modules manage the state of each cell on the game board, turning on the appropriate 
	 // red or green pixel based on the player and the current state of the column.
    ledController r1c1(.redOn(red[15][4]), .grnOn(green[15][4]), .clk(clk), .reset(reset), .rowcounter(counters[0]), .player(player), .row(1));
    ledController r2c1(.redOn(red[14][4]), .grnOn(green[14][4]), .clk(clk), .reset(reset), .rowcounter(counters[0]), .player(player), .row(2));
    ledController r3c1(.redOn(red[13][4]), .grnOn(green[13][4]), .clk(clk), .reset(reset), .rowcounter(counters[0]), .player(player), .row(3));
    ledController r4c1(.redOn(red[12][4]), .grnOn(green[12][4]), .clk(clk), .reset(reset), .rowcounter(counters[0]), .player(player), .row(4));
    ledController r5c1(.redOn(red[11][4]), .grnOn(green[11][4]), .clk(clk), .reset(reset), .rowcounter(counters[0]), .player(player), .row(5));
    ledController r6c1(.redOn(red[10][4]), .grnOn(green[10][4]), .clk(clk), .reset(reset), .rowcounter(counters[0]), .player(player), .row(6));

    // Column 2
    ledController r1c2(.redOn(red[15][5]), .grnOn(green[15][5]), .clk(clk), .reset(reset), .rowcounter(counters[1]), .player(player), .row(1));
    ledController r2c2(.redOn(red[14][5]), .grnOn(green[14][5]), .clk(clk), .reset(reset), .rowcounter(counters[1]), .player(player), .row(2));
    ledController r3c2(.redOn(red[13][5]), .grnOn(green[13][5]), .clk(clk), .reset(reset), .rowcounter(counters[1]), .player(player), .row(3));
    ledController r4c2(.redOn(red[12][5]), .grnOn(green[12][5]), .clk(clk), .reset(reset), .rowcounter(counters[1]), .player(player), .row(4));
    ledController r5c2(.redOn(red[11][5]), .grnOn(green[11][5]), .clk(clk), .reset(reset), .rowcounter(counters[1]), .player(player), .row(5));
    ledController r6c2(.redOn(red[10][5]), .grnOn(green[10][5]), .clk(clk), .reset(reset), .rowcounter(counters[1]), .player(player), .row(6));

    // Column 3
    ledController r1c3(.redOn(red[15][6]), .grnOn(green[15][6]), .clk(clk), .reset(reset), .rowcounter(counters[2]), .player(player), .row(1));
    ledController r2c3(.redOn(red[14][6]), .grnOn(green[14][6]), .clk(clk), .reset(reset), .rowcounter(counters[2]), .player(player), .row(2));
    ledController r3c3(.redOn(red[13][6]), .grnOn(green[13][6]), .clk(clk), .reset(reset), .rowcounter(counters[2]), .player(player), .row(3));
    ledController r4c3(.redOn(red[12][6]), .grnOn(green[12][6]), .clk(clk), .reset(reset), .rowcounter(counters[2]), .player(player), .row(4));
    ledController r5c3(.redOn(red[11][6]), .grnOn(green[11][6]), .clk(clk), .reset(reset), .rowcounter(counters[2]), .player(player), .row(5));
    ledController r6c3(.redOn(red[10][6]), .grnOn(green[10][6]), .clk(clk), .reset(reset), .rowcounter(counters[2]), .player(player), .row(6));

    // Column 4
    ledController r1c4(.redOn(red[15][7]), .grnOn(green[15][7]), .clk(clk), .reset(reset), .rowcounter(counters[3]), .player(player), .row(1));
    ledController r2c4(.redOn(red[14][7]), .grnOn(green[14][7]), .clk(clk), .reset(reset), .rowcounter(counters[3]), .player(player), .row(2));
    ledController r3c4(.redOn(red[13][7]), .grnOn(green[13][7]), .clk(clk), .reset(reset), .rowcounter(counters[3]), .player(player), .row(3));
    ledController r4c4(.redOn(red[12][7]), .grnOn(green[12][7]), .clk(clk), .reset(reset), .rowcounter(counters[3]), .player(player), .row(4));
    ledController r5c4(.redOn(red[11][7]), .grnOn(green[11][7]), .clk(clk), .reset(reset), .rowcounter(counters[3]), .player(player), .row(5));
    ledController r6c4(.redOn(red[10][7]), .grnOn(green[10][7]), .clk(clk), .reset(reset), .rowcounter(counters[3]), .player(player), .row(6));

    // Column 5
    ledController r1c5(.redOn(red[15][8]), .grnOn(green[15][8]), .clk(clk), .reset(reset), .rowcounter(counters[4]), .player(player), .row(1));
    ledController r2c5(.redOn(red[14][8]), .grnOn(green[14][8]), .clk(clk), .reset(reset), .rowcounter(counters[4]), .player(player), .row(2));
    ledController r3c5(.redOn(red[13][8]), .grnOn(green[13][8]), .clk(clk), .reset(reset), .rowcounter(counters[4]), .player(player), .row(3));
    ledController r4c5(.redOn(red[12][8]), .grnOn(green[12][8]), .clk(clk), .reset(reset), .rowcounter(counters[4]), .player(player), .row(4));
    ledController r5c5(.redOn(red[11][8]), .grnOn(green[11][8]), .clk(clk), .reset(reset), .rowcounter(counters[4]), .player(player), .row(5));
    ledController r6c5(.redOn(red[10][8]), .grnOn(green[10][8]), .clk(clk), .reset(reset), .rowcounter(counters[4]), .player(player), .row(6));

    // Column 6
    ledController r1c6(.redOn(red[15][9]), .grnOn(green[15][9]), .clk(clk), .reset(reset), .rowcounter(counters[5]), .player(player), .row(1));
    ledController r2c6(.redOn(red[14][9]), .grnOn(green[14][9]), .clk(clk), .reset(reset), .rowcounter(counters[5]), .player(player), .row(2));
    ledController r3c6(.redOn(red[13][9]), .grnOn(green[13][9]), .clk(clk), .reset(reset), .rowcounter(counters[5]), .player(player), .row(3));
    ledController r4c6(.redOn(red[12][9]), .grnOn(green[12][9]), .clk(clk), .reset(reset), .rowcounter(counters[5]), .player(player), .row(4));
    ledController r5c6(.redOn(red[11][9]), .grnOn(green[11][9]), .clk(clk), .reset(reset), .rowcounter(counters[5]), .player(player), .row(5));
    ledController r6c6(.redOn(red[10][9]), .grnOn(green[10][9]), .clk(clk), .reset(reset), .rowcounter(counters[5]), .player(player), .row(6));

    // Column 7
    ledController r1c7(.redOn(red[15][10]), .grnOn(green[15][10]), .clk(clk), .reset(reset), .rowcounter(counters[6]), .player(player), .row(1));
    ledController r2c7(.redOn(red[14][10]), .grnOn(green[14][10]), .clk(clk), .reset(reset), .rowcounter(counters[6]), .player(player), .row(2));
    ledController r3c7(.redOn(red[13][10]), .grnOn(green[13][10]), .clk(clk), .reset(reset), .rowcounter(counters[6]), .player(player), .row(3));
    ledController r4c7(.redOn(red[12][10]), .grnOn(green[12][10]), .clk(clk), .reset(reset), .rowcounter(counters[6]), .player(player), .row(4));
    ledController r5c7(.redOn(red[11][10]), .grnOn(green[11][10]), .clk(clk), .reset(reset), .rowcounter(counters[6]), .player(player), .row(5));
    ledController r6c7(.redOn(red[10][10]), .grnOn(green[10][10]), .clk(clk), .reset(reset), .rowcounter(counters[6]), .player(player), .row(6));

    // Column 8
    ledController r1c8(.redOn(red[15][11]), .grnOn(green[15][11]), .clk(clk), .reset(reset), .rowcounter(counters[7]), .player(player), .row(1));
    ledController r2c8(.redOn(red[14][11]), .grnOn(green[14][11]), .clk(clk), .reset(reset), .rowcounter(counters[7]), .player(player), .row(2));
    ledController r3c8(.redOn(red[13][11]), .grnOn(green[13][11]), .clk(clk), .reset(reset), .rowcounter(counters[7]), .player(player), .row(3));
    ledController r4c8(.redOn(red[12][11]), .grnOn(green[12][11]), .clk(clk), .reset(reset), .rowcounter(counters[7]), .player(player), .row(4));
    ledController r5c8(.redOn(red[11][11]), .grnOn(green[11][11]), .clk(clk), .reset(reset), .rowcounter(counters[7]), .player(player), .row(5));
    ledController r6c8(.redOn(red[10][11]), .grnOn(green[10][11]), .clk(clk), .reset(reset), .rowcounter(counters[7]), .player(player), .row(6));

    logic [4:0] newtokencolumn;           // New token column
    logic [4:0] newtokenrow;              // New token row

    // Sequential logic to update the gameBoard
    always_ff @(posedge clk) begin
        redpixels <= red;                 // Update red pixel array
        grnpixels <= green;               // Update green pixel array
        
        if (inputcolumn != 0) begin
            prevtokencolumn <= newtokencolumn;  // Store previous token column
            prevtokenrow <= newtokenrow;        // Store previous token row
            
            newtokencolumn <= inputcolumn + 4'd3;            // Calculate new token column
            newtokenrow <= 4'd15 - counters[inputcolumn - 4'd1]; // Calculate new token row
        end
    end

endmodule

module gameBoard_testbench();
    // Testbench signals
    logic clk, reset, player;
    logic [3:0] inputcolumn;
    logic [15:0][15:0] redpixels, grnpixels;
    logic [7:0][2:0] counters;
    logic [4:0] prevtokenrow, prevtokencolumn;

    // Instantiate the DUT (Device Under Test)
    gameBoard dut (
        .clk(clk),
        .reset(reset),
        .player(player),
        .inputcolumn(inputcolumn),
        .redpixels(redpixels),
        .grnpixels(grnpixels),
        .counters(counters),
        .prevtokenrow(prevtokenrow),
        .prevtokencolumn(prevtokencolumn)
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
        player = 0;
        inputcolumn = 0;

        // Apply reset
        #10 reset = 0;

        // Test placing tokens in various columns
        repeat (2) begin
            for (int col = 1; col <= 8; col++) begin
                inputcolumn = col; #20;
            end
            player = ~player;
        end

        // Apply and release reset during operation
        reset = 1; #10;
        reset = 0; #10;

        // Test placing tokens after reset
        player = 0;
        inputcolumn = 1; #20;
        inputcolumn = 2; #20;

        player = 1;
        inputcolumn = 3; #20;
        inputcolumn = 4; #20;

        // End simulation
        $stop;
    end
endmodule

