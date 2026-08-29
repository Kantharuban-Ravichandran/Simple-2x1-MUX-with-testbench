//Adding Interface to the testbench
//Only in testbench

module mux_2x1(
  
  input bit a,
  input bit b,
  input bit sel,
  output bit y);
  
  
  always_comb
  begin
     y=sel?b:a;
  end
endmodule
  
//Tb code
interface mux_if;
  logic a,b,sel,y;
endinterface

module tb();
  
  mux_if vif();
  logic expected;
  
  mux_2x1 dut (
    .a(vif.a),
    .b(vif.b),
    .sel(vif.sel),
    .y(vif.y)
  );
  
  initial begin
    vif.sel=0;vif.a=0;vif.b=1;
    //l=0;a=0;b=0;
     #10;
    $display("y=%b" , vif.y);
  if(vif.sel == 0)
      assign expected = vif.a;
    else 
     assign expected = vif.b;
    
  assert(vif.y==expected)
      $display ("PASS" );
    else
      $display("Failed");  

    
    
 vif.sel=1;vif.a=0;vif.b=1;
    //l=0;a=0;b=0;
      #10;
    $display("y=%b" , vif.y);
if(vif.sel == 0)
      assign expected = vif.a;
    else 
     assign expected = vif.b;
    
assert(vif.y==expected)
      $display ("PASS" );
    else
      $display("Failed");
    
  end
endmodule
 
