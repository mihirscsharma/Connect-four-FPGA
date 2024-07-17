// The DE1_SoC module provides an interface to control and display the 
// state of a Connect Four game using the board's inputs, outputs, and peripherals. 

module DE1_SoC #(parameter whichClock = 20) (
    input logic CLOCK_50,           // 50MHz clock input
    input logic [3:0] KEY,          // 4-bit key input
    input logic [9:0] SW,           // 10-bit switch input
    output logic [9:0] LEDR,        // 10-bit LED output
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,  // 7-segment display outputs
    output logic [35:0] GPIO_1      // 36-bit GPIO output
);

    // Default values to turn off the HEX displays
    assign HEX1 = 7'b1111111;
    assign HEX2 = 7'b1111111;
    assign HEX3 = 7'b1111111;
    assign HEX4 = 7'b1111111;

    logic [15:0][15:0] RedPixels;   // 16x16 array representing red LEDs
    logic [15:0][15:0] GrnPixels;   // 16x16 array representing green LEDs
    logic reset;                    // Reset signal

    // Generate clk off of CLOCK_50, whichClock picks rate
    logic [31:0] clk;               // Clock divider output
    logic SYSTEM_CLOCK;             // System clock signal
    clock_divider cdiv (
        .clock(CLOCK_50), 
        .divided_clocks(clk)
    );
    assign SYSTEM_CLOCK = clk[14];  // 1526 Hz clock signal

    // Assign reset signal to SW[9]
    assign reset = SW[9];           
    assign LEDR = 10'b0000000000;   // Turn off all LEDs

    // Instantiate connectFour game module
    connectFour game(
        .player_7seg(HEX0), 
        .winner(HEX5), 
        .RedPixels(RedPixels), 
        .GrnPixels(GrnPixels), 
        .clk(clk[whichClock]), 
        .reset(reset), 
        .sw(SW[7:0])
    );

    // Instantiate LEDDriver module
    LEDDriver Driver (
        .CLK(SYSTEM_CLOCK), 
        .RST(reset), 
        .EnableCount(1'b1), 
        .RedPixels(RedPixels), 
        .GrnPixels(GrnPixels), 
        .GPIO_1(GPIO_1)
    );

endmodule
