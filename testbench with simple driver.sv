interface mux_if;
  logic a,b,sel,y;
endinterface

class class_test;
  virtual mux_if vif2;
  
  function new(virtual mux_if vif);
    this.vif2=vif;
  endfunction
  
function void drive(logic a,logic b,logic sel);
     this.vif2.a= a;
    this.vif2.b= b;
    this.vif2.sel= sel;
  endfunction
    
  
  function void display();
    $display(" %b , %b , %b " ,vif2.a,vif2.b,vif2.sel);
  endfunction
endclass

module tb();
  
  mux_if vif();
  class_test ct;
  logic expected;
  
  mux_2x1 dut (
    .a(vif.a),
    .b(vif.b),
    .sel(vif.sel),
    .y(vif.y)
  );
  
  initial begin
    
    ct=new(vif);
    
    ct.drive(1,0,1);
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
    
    
    ct.drive(0,1,0);
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
