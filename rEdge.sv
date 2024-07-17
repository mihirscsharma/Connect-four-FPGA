// The rEdge (Rising Edge) module is designed to detect a rising edge on a switch input signal (sw).
// A rising edge occurs when the signal transitions from a low state (0) to a high state (1).

module rEdge (
    input logic clk, reset, sw,     // Clock, reset, and switch inputs
    output logic out                // Output signal
);

    // Define states for the edge detector
    enum logic {S0 = 1'b0, S1 = 1'b1} ps, ns;

    // Combinational logic to determine next state and output
    always_comb begin
        case (ps)
            S0: begin
                if (sw) begin        // If switch is turned on
                    ns = S1;
                    out = 1'b1;      // Output a 1
                end else begin
                    ns = S0;
                    out = 1'b0;      // Output a 0
                end
            end
            S1: begin
                if (sw) begin        // If switch remains on
                    ns = S1;
                    out = 1'b0;      // Output a 0 to detect edge only
                end else begin
                    ns = S0;
                    out = 1'b0;      // Output a 0
                end
            end
            default: ns = ps;        // Default state transition
        endcase
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (reset)
            ps <= S0;               // Reset to state S0
        else
            ps <= ns;               // Update to next state
    end

endmodule

module rEdge_testbench();
    // Testbench signals
    logic clk;
    logic reset;
    logic sw;
    logic out;

    // Instantiate the DUT (Device Under Test)
    rEdge dut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .out(out)
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
        sw = 0;

        // Apply reset
        #10 reset = 0;  // Release reset

        // Test rising edge detection
        sw = 0; #10;   // Switch remains off
        sw = 1; #10;   // Rising edge, out should be 1 for one clock cycle
        sw = 1; #10;   // No edge, out should be 0
        sw = 0; #10;   // Falling edge, out should remain 0
        sw = 1; #10;   // Rising edge, out should be 1 for one clock cycle
        sw = 1; #10;   // No edge, out should be 0

        // Apply reset during operation
        reset = 1; #10; // Activate reset
        reset = 0; #10; // Deactivate reset

        // Test rising edge detection after reset
        sw = 0; #10;   // Switch remains off
        sw = 1; #10;   // Rising edge, out should be 1 for one clock cycle
        sw = 1; #10;   // No edge, out should be 0
        sw = 0; #10;   // Falling edge, out should remain 0
        sw = 1; #10;   // Rising edge, out should be 1 for one clock cycle

        // End simulation
        $stop;
    end
endmodule
