library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CE_gen_44100_tb is
end;

architecture bench of CE_gen_44100_tb is

  component CE_gen_44100
      Port (
          clk     : IN STD_LOGIC;
          rst     : IN STD_LOGIC;
          clk_out : OUT STD_LOGIC
      );
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal clk_out: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: CE_gen_44100 port map ( clk     => clk,
                               rst     => rst,
                               clk_out => clk_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
    rst <= '1';
    wait for 10*clock_period;
    rst <= '0';
    
    -- Put test bench stimulus code here

    wait for 10000*clock_period;

    stop_the_clock <= true;
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