// The userInput module is designed to synchronize the input switches (sw) 
// to the system clock (clk) and detect rising edges of the switch signals. 

module userInput(
    input logic clk, reset,           // Clock and reset inputs
    input logic [7:0] sw,             // 8-bit switch input
    output logic [7:0] sw_sync        // 8-bit synchronized switch output
);

    logic [7:0] sw_temp;              // Temporary storage for synchronized switch values

    // Instantiate edge detectors for each switch input
    rEdge e1(.out(sw_temp[0]), .clk(clk), .reset(reset), .sw(sw[0]));
    rEdge e2(.out(sw_temp[1]), .clk(clk), .reset(reset), .sw(sw[1]));
    rEdge e3(.out(sw_temp[2]), .clk(clk), .reset(reset), .sw(sw[2]));
    rEdge e4(.out(sw_temp[3]), .clk(clk), .reset(reset), .sw(sw[3]));
    rEdge e5(.out(sw_temp[4]), .clk(clk), .reset(reset), .sw(sw[4]));
    rEdge e6(.out(sw_temp[5]), .clk(clk), .reset(reset), .sw(sw[5]));
    rEdge e7(.out(sw_temp[6]), .clk(clk), .reset(reset), .sw(sw[6]));
    rEdge e8(.out(sw_temp[7]), .clk(clk), .reset(reset), .sw(sw[7]));

    // Assign synchronized switch values to output
    assign sw_sync = sw_temp;

endmodule

module userInput_testbench();
    // Testbench signals
    logic clk;
    logic reset;
    logic [7:0] sw;
    logic [7:0] sw_sync;

    // Instantiate the DUT (Device Under Test)
    userInput dut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .sw_sync(sw_sync)
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
        #10;

        // Release reset
        reset = 0;

        // Test individual switch inputs
        sw[0] = 1; #20; sw[0] = 0; #20;
        sw[1] = 1; #20; sw[1] = 0; #20;
        sw[2] = 1; #20; sw[2] = 0; #20;
        sw[3] = 1; #20; sw[3] = 0; #20;
        sw[4] = 1; #20; sw[4] = 0; #20;
        sw[5] = 1; #20; sw[5] = 0; #20;
        sw[6] = 1; #20; sw[6] = 0; #20;
        sw[7] = 1; #20; sw[7] = 0; #20;

        // Test multiple switch inputs
        sw = 8'b10101010; #20;
        sw = 8'b01010101; #20;

        // Apply and release reset during operation
        reset = 1; #10;
        reset = 0; #10;

        // Test more switch inputs after reset
        sw[0] = 1; #20; sw[0] = 0; #20;
        sw[7] = 1; #20; sw[7] = 0; #20;

        // End simulation
        $stop;
    end
endmodule
