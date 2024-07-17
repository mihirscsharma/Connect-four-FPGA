// The seg7 module is designed to convert a 4-bit binary-coded decimal (BCD) input 
//into a 7-segment display code. This conversion allows the BCD value to be displayed 
//on a 7-segment display, which is commonly used in digital systems to display numerical information.


module seg7 (
    input logic [3:0] bcd,      // 4-bit binary-coded decimal input
    output logic [6:0] leds     // 7-segment display output
);

    // Combinational logic to map BCD to 7-segment display encoding
    always_comb begin
        case (bcd)
            4'b0000: leds = 7'b1000000; // 0
            4'b0001: leds = 7'b1111001; // 1
            4'b0010: leds = 7'b0100100; // 2
            4'b0011: leds = 7'b0110000; // 3
            4'b0100: leds = 7'b0011001; // 4
            4'b0101: leds = 7'b0010010; // 5
            4'b0110: leds = 7'b0000010; // 6
            4'b0111: leds = 7'b1111000; // 7
            4'b1000: leds = 7'b0000000; // 8
            4'b1001: leds = 7'b0010000; // 9
            default: leds = 7'bXXXXXXX; // Undefined value
        endcase
    end
endmodule
