
module test;
  
  //inputs
  reg clock;
  reg reset;
  reg mode;
  reg button1;
  reg button2;
  reg button3;
  
  //outputs
  wire [7:0] leds;
  
  //Instantiate the units
  votingMachine uut(
    .clock(clock),
    .reset(reset),
    .mode(mode),
    .button1(button1),
    .button2(button2),
    .button3(button3),
    .led(led)
  );
  
  initial begin
    clock=0;
    forever #5 clock =~clock;
  end
  
  initial begin
    //initialize input
    reset=1; mode=0; button1=0; button2=0;button3=0;
    
    #100; //for resetting
    
    //cases
    #100 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=1; button2=0;button3=0;
    #10 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=1; button2=0;button3=0;
    #200 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    #10 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    
    #5 reset=0; mode=0; button1=0; button2=1;button3=0;
    #200 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    #10 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    
    #5 reset=0; mode=0; button1=0; button2=1;button3=1;
    #200 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    #10 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    
    #5 reset=0; mode=1; button1=0; button2=1;button3=0;
    #200 reset=0; mode=1; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    #10 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    
    #5 reset=0; mode=0; button1=0; button2=0;button3=1;
    #200 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    #10 reset=0; mode=0; button1=0; button2=0;button3=0;
    #5 reset=0; mode=0; button1=0; button2=0;button3=0;
    
    $finish;
  end
  
  initial
    begin
      $dumpvars;
      $dumpfile("dump.vcd");
      
    end
  
  initial
    $monitor($time,  "mode=%b, button1=%b, button2=%b,button3=%b, led=%d", mode,button1,button2,button3,led);
endmodule
