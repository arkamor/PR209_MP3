library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity BP_tb is
end;

architecture bench of BP_tb is

  component BP
      PORT (
          clk : in std_logic;
          rst : in std_logic;
          b_input  : in  std_logic;
          b_output : out std_logic
      );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal b_input: std_logic;
  signal b_output: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: BP port map ( clk      => clk,
                     rst      => rst,
                     b_input  => b_input,
                     b_output => b_output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    b_input <= '0';
    rst <= '0';
    wait for 5 ns;
    rst <= '1';
    wait for 5 ns;

    b_input <= '1';
    wait for 54 ns;
    
    b_input <= '0';
    wait for clock_period;
    b_input <= '1';
    wait for 15 ns;
    
    b_input <= '0';
    wait for clock_period;
    b_input <= '1';
    wait for 542 ns;

    -- Put test bench stimulus code here


    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;