
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity gestion_freq_tb is
end;

architecture bench of gestion_freq_tb is

  component gestion_freq
      PORT (
          clk : in std_logic;
          rst : in std_logic;
          output_10h : out std_logic;
          output_3k  : out std_logic
      );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal output_10h: std_logic := '0';
  signal output_3k: std_logic := '0';

  constant clock_period: time := 2 ps;
  signal stop_the_clock: boolean;

begin

  uut: gestion_freq port map ( clk        => clk,
                               rst        => rst,
                               output_10h => output_10h,
                               output_3k  => output_3k );

  stimulus: process
  begin
  
    -- Put initialisation code here
    rst <= '1';
    wait for clock_period;
    
    rst <= '0';
    
    while output_10h='0' loop
        wait for clock_period;
    end loop;
    
    while output_10h='1' loop
        wait for clock_period;
    end loop;
    
    while output_10h='0' loop
        wait for clock_period;
    end loop;
    
    while output_10h='1' loop
        wait for clock_period;
    end loop;
    
    
    

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