
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Top_Level_Partie2_tb is
end;

architecture bench of Top_Level_Partie2_tb is

  component Top_Level_Partie2
      PORT (
          btnCpuReset : in STD_LOGIC;
          clk         : in  STD_LOGIC;
          
          ampPWM : out STD_LOGIC;
          ampSD  : out STD_LOGIC
      );
  end component;

  signal btnCpuReset: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal ampPWM: STD_LOGIC;
  signal ampSD: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Top_Level_Partie2 port map ( btnCpuReset => btnCpuReset,
                                    clk         => clk,
                                    ampPWM      => ampPWM,
                                    ampSD       => ampSD );

  stimulus: process
  begin
  
    -- Put initialisation code here
    btnCpuReset <= '0';
    wait for 10*clock_period;
    btnCpuReset <= '1';
    

    -- Put test bench stimulus code here

    --stop_the_clock <= true;
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