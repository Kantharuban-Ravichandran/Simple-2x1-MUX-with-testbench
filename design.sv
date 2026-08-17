// 2x1 Multiplexer Module
module mux2x1 (
    input  logic a,    // Input 0
    input  logic b,    // Input 1
    input  logic sel,  // Select line
    output logic y     // Output
);
    assign y = sel ? b : a;
endmodule
