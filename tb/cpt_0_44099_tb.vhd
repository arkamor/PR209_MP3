library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cpt_0_44099_tb is
end;

architecture bench of cpt_0_44099_tb is

  component cpt_0_44099
      Port (
          clk     : IN STD_LOGIC;
          rst     : IN STD_LOGIC;
          ce      : IN STD_LOGIC;
          out_cpt : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
      );
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal ce: STD_LOGIC;
  signal out_cpt: STD_LOGIC_VECTOR (15 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: cpt_0_44099 port map ( clk     => clk,
                              rst     => rst,
                              ce      => ce,
                              out_cpt => out_cpt );

  stimulus: process
  begin
  
    stop_the_clock <= false;
    
    ce <= '0';
    rst <= '1';
    wait for 5*clock_period;
    ce <= '1';
    rst <= '0';
    wait for 50000*clock_period;
    
    ce <= '0';
    
    wait for 10*clock_period;

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