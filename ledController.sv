// The ledController module is designed to control the LEDs for the Connect Four game, turning 
// on the appropriate red or green LED based on the current state of the game and the player's move. 
// It uses a finite state machine (FSM) to manage the LED states and transitions.


module ledController (
    input logic clk, reset,             // Clock and reset inputs
    input logic [2:0] rowcounter,       // Row counter input
    input logic player,                 // Player input
    input logic [2:0] row,              // Row input
    output logic redOn,                 // Red LED output
    output logic grnOn                  // Green LED output
);

    // Define states for the FSM
    enum logic [1:0] {Off = 2'b00, RedOn = 2'b01, GrnOn = 2'b10} ps, ns;

    // Combinational logic to determine next state and outputs
    always_comb begin
        case (ps)
            Off: begin
                if ((rowcounter == row) && (!player)) begin
                    ns = RedOn;       // Transition to RedOn state
                    redOn = 0;
                    grnOn = 0;
                end else if ((rowcounter == row) && player) begin
                    ns = GrnOn;       // Transition to GrnOn state
                    redOn = 0;
                    grnOn = 0;
                end else begin
                    ns = Off;         // Remain in Off state
                    redOn = 0;
                    grnOn = 0;
                end
            end
            RedOn: begin
                ns = ps;              // Remain in RedOn state
                redOn = 1;            // Turn on red LED
                grnOn = 0;
            end
            GrnOn: begin
                ns = ps;              // Remain in GrnOn state
                redOn = 0;
                grnOn = 1;            // Turn on green LED
            end
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (reset)
            ps <= Off;               // Reset to Off state
        else
            ps <= ns;                // Update to next state
    end

endmodule

module ledController_testbench();

    // Declare logic for inputs and outputs
    logic clk, reset;
    logic [2:0] rowcounter;
    logic player;
    logic [2:0] row;
    logic redOn, grnOn;

    // Instantiate the Device Under Test (DUT)
    ledController dut (
        .clk(clk),
        .reset(reset),
        .rowcounter(rowcounter),
        .player(player),
        .row(row),
        .redOn(redOn),
        .grnOn(grnOn)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units (10 time units period)
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;  // Start with reset active
        rowcounter = 3'b000;
        player = 0;
        row = 3'b000;
        #10 reset = 0;  // Release reset

        // Test cases

        // Scenario 1: Player 1 places a token in row 0
        rowcounter = 3'b000; row = 3'b000; player = 0; #20;

        // Scenario 2: Player 2 places a token in row 1
        rowcounter = 3'b001; row = 3'b001; player = 1; #20;

        // Scenario 3: Player 1 places a token in row 2
        rowcounter = 3'b010; row = 3'b010; player = 0; #20;

        // Scenario 4: Player 2 places a token in row 3
        rowcounter = 3'b011; row = 3'b011; player = 1; #20;

        // Scenario 5: Test reset functionality
        reset = 1; #10;
        reset = 0; #10;

        // Scenario 6: Test when no token is placed
        rowcounter = 3'b100; row = 3'b011; player = 0; #20;

        $stop; // End simulation
    end

endmodule


