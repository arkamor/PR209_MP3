library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clk_divider_tb is
end;

architecture bench of clk_divider_tb is

  component clk_divider
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

  uut: clk_divider port map ( clk     => clk,
                              rst     => rst,
                              clk_out => clk_out );

  stimulus: process
  begin

    rst <= '1';
    wait for 10*clock_period;
    rst <= '0';

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