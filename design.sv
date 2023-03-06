module buttonControl(
  input clock,
  input reset,
  input button,
  output reg valid_vote
);
  
  reg[30:0] counter;
  
  always @(posedge clock)
    begin
      if(reset)
        counter <=0;
      else
        begin
          if(button & counter < 11)
            counter <= counter+1;
          else if (!button)
            counter <=0;
         end
    end
  
  always @(posedge clock)
    begin
      if (reset)
        valid_vote <= 1'b0;
      else
        begin
          if (counter==10)
            valid_vote <= 1'b1;
          else
            valid_vote <= 1'b0;
          
        end
    end
endmodule

module voteLogger(
  input clock,
  input reset,
  input mode, /* mode 0 vote can be cast in mode 1 votes displayed */
  input party1Vote_valid,
  input party2Vote_valid,
  input party3Vote_valid,
  output reg [7:0] party1Vote_recvd,
  output reg [7:0] party2Vote_recvd,
  output reg [7:0] party3Vote_recvd
);
  
  always @(posedge clock)
    begin
      if (reset)
        begin
          party1Vote_recvd <= 0;
          party2Vote_recvd <= 0;
          party3Vote_recvd <= 0;
        end
      else
        begin
          if (party1Vote_valid & mode == 0)
            party1Vote_recvd <= party1Vote_recvd +1;
          else if (party2Vote_valid & mode == 0)
            party2Vote_recvd <= party2Vote_recvd +1;
          else if (party3Vote_valid & mode == 0)
            party3Vote_recvd <= party3Vote_recvd +1;
          
        end
    end
endmodule
            
          
module modeControl(
  input clock,
  input reset,
  input mode, /* mode 0 vote can be cast in mode 1 votes displayed */
  input valid_vote_Casted,
  input [7:0] party1Vote,
  input [7:0] party2Vote,
  input [7:0] party3Vote,
  input party1_button_press,
  input party2_button_press,
  input party3_button_press,
  output reg [7:0] leds
);
  reg [30:0] counter; //for lightup the LED s
  
  always @(posedge clock)
    begin
      if (reset)
        counter <=0; 
      else if (valid_vote_Casted)
        counter <= counter +1;
      else if (counter !=0 & counter <10)
        counter <= counter +1;
      else
        counter <=0;
    end
  
  
  always @(posedge clock)
    begin
      if (reset)
        leds <=0;
      else
        begin
          if (mode==0 & counter >0)
            leds <= 8'hFF;
          else if (mode ==0)
            leds <= 8'h00;
          else if (mode ==1)
            begin
              if(party1_button_press)
                leds <= party1Vote;
              else if(party2_button_press)
                leds <= party2Vote;
              else if(party3_button_press)
                leds <= party3Vote ;
            end
        end
    end
endmodule




module votingMachine(
  input clock,
  input reset,
  input mode, /* mode 0 vote can be cast in mode 1 votes displayed */
  input button1,
  input button2,
  input button3,
  output reg [7:0] led
  
);
  
  wire valid_vote_1;
  wire valid_vote_2;
  wire valid_vote_3;
  wire party1Vote_count;
  wire party2Vote_count;
  wire party3Vote_count;
  wire anyValidVote;
  
  assign anyValidVote = valid_vote_1|valid_vote_2|valid_vote_3;
    
    buttonControl bc1(
      .clock(clock),
      .reset(reset),
      .button(button1),
      .valid_vote(valid_vote_1)
    );
  
   buttonControl bc2(
      .clock(clock),
      .reset(reset),
      .button(button1),
     .valid_vote(valid_vote_2)
    );
  
   buttonControl bc3(
      .clock(clock),
      .reset(reset),
      .button(button1),
     .valid_vote(valid_vote_3)
    );
  
  voteLogger VL(
    .clock(clock),
    .reset(reset),
    .mode(mode),
    .party1Vote_valid(valid_vote_1),
    .party2Vote_valid(valid_vote_2),
    .party3Vote_valid(valid_vote_3),
    .party1Vote_recvd(party1Vote_recvd),
    .party2Vote_recvd(party2Vote_recvd),
    .party3Vote_recvd(party3Vote_recvd)
  );
  
  modeControl MC(
    .clock(clock),
    .reset(reset),
    .mode(mode),
    .valid_vote_Casted(anyValidVote),
    .party1Vote(party1Vote_recvd),
    .party2Vote(party2Vote_recvd),
    .party3Vote(party3Vote_recvd),
    .party1_button_press(valid_Vote_1),
    .party2_button_press(valid_Vote_2),
    .party3_button_press(valid_Vote_3),
    .leds(led)
  );
endmodule
