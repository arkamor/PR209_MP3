
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mod8_tb is
end;

architecture bench of mod8_tb is

  component mod8
      PORT (
          clk : in std_logic;
          rst : in std_logic;
          ce  : in std_logic;
          an      : out std_logic_vector(7 DOWNTO 0);
          seg_com : out std_logic_vector(2 DOWNTO 0)
      );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal ce: std_logic;
  signal an: std_logic_vector(7 DOWNTO 0);
  signal seg_com: std_logic_vector(2 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: mod8 port map ( clk     => clk,
                       rst     => rst,
                       ce      => ce,
                       an      => an,
                       seg_com => seg_com );

  stimulus: process
  begin
  
    -- Put initialisation code here
    ce <= '1';
    rst <= '0';
    
    wait for 1000*clock_period;
    

    -- Put test bench stimulus code here

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