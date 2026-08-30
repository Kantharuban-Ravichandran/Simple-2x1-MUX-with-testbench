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
  





interface mux_if;
  logic a,b,sel,y;
endinterface

class transaction;
  logic a,b,sel;
endclass
                

class class_test;
  virtual mux_if vif2;
  
  function new(virtual mux_if vif);
    this.vif2=vif;
  endfunction
  
  function void drive(transaction tr1);
     this.vif2.a= tr1.a;
    this.vif2.b= tr1.b;
    this.vif2.sel= tr1.sel;
  endfunction
    
  
  function void display();
    $display(" %b , %b , %b " ,vif2.a,vif2.b,vif2.sel);
  endfunction
endclass

module tb();
  
  mux_if vif();
  class_test ct;
  transaction tr;
  transaction tr2;
  logic expected;
  
  mux_2x1 dut (
    .a(vif.a),
    .b(vif.b),
    .sel(vif.sel),
    .y(vif.y)
  );
  
  initial begin
    
    ct=new(vif);
    tr=new();
    tr2=new();
    tr.a=1;  tr.b=0; tr.sel=1;
    $display("%b ,%b, %b " ,tr.a,tr.b,tr.sel);
    
    ct.drive(tr);
    //l=0;a=0;b=0;
     #10;
    ct.display();
  if(vif.sel == 0)
       expected = vif.a;
    else 
      expected = vif.b;
    
  assert(vif.y==expected)
      $display ("PASS" );
    else
      $display("Failed");  
    
    
    tr2.a=0;  tr2.b=1; tr2.sel=0;
    ct.drive(tr2);
    //l=0;a=0;b=0;
     #10;
    ct.display();
  if(vif.sel == 0)
       expected = vif.a;
    else 
      expected = vif.b;
    
  assert(vif.y==expected)
      $display ("PASS" );
    else
      $display("Failed"); 
    
  end
endmodule
