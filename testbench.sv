module tb_top;
  
  logic a,b,sel;
  logic y;
  
  mux2x1 dut(
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
  );
  
  initial begin
    $monitor("Time=%0t | a=%b b=%b sel=%b -> y=%b", $time, a, b, sel, y);
    // Test Case 1: Select Input A (sel = 0)
        sel = 0; a = 0; b = 1; #10;
        sel = 0; a = 1; b = 0; #10;

        // Test Case 2: Select Input B (sel = 1)
        sel = 1; a = 0; b = 1; #10;
        sel = 1; a = 1; b = 0; #10;

        $finish;
    end
endmodule





//with checker
module tb();
  
  logic a,b,sel,y;
  logic expected;
  
  mux_2x1 dut (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
  );
  
  initial begin
    
    sel=0;a=0;b=0;
    $display("y=%b" , y);
    #10;
    if(sel == 0)
      assign expected = a;
    else 
     assign expected = b;
    
    if(y == expected)
      $display ("PASS" );
    else
      $display("Failed");
    
    
    sel=1;a=0;b=1;
    #10;
    $display("y=%b" , y);
    if(sel == 0)
      assign expected = a;
    else 
     assign expected = b;
    
    if(y == expected)
      $display ("PASS" );
    else
      $display("Failed");
    
  end
endmodule
