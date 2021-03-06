library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cpt_1_599_tb is
end;

architecture bench of cpt_1_599_tb is

  component cpt_1_599
      Port (
          clk     : in STD_LOGIC;
          ce      : in STD_LOGIC;
          rst     : in STD_LOGIC;
          in_inc   : in STD_LOGIC;
          in_dec   : in STD_LOGIC;
          in_raz   : in STD_LOGIC;
          out_cpt : out STD_LOGIC_VECTOR (9 downto 0)
      );
  end component;

  signal clk: STD_LOGIC;
  signal ce: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal in_inc: STD_LOGIC;
  signal in_dec: STD_LOGIC;
  signal in_raz: STD_LOGIC;
  signal out_cpt: STD_LOGIC_VECTOR (9 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: cpt_1_599 port map ( clk     => clk,
                            ce      => ce,
                            rst     => rst,
                            in_inc  => in_inc,
                            in_dec  => in_dec,
                            in_raz  => in_raz,
                            out_cpt => out_cpt );

  stimulus: process
  begin
  
    stop_the_clock <= false;
    
    rst <= '0';
    wait for 5*clock_period;
    rst <= '1';
    wait for clock_period;
    
    
    in_inc <= '1';
    in_dec <= '0';
    in_raz <= '0';
    
    wait for 210*clock_period;
    
    in_inc <= '1';
    in_dec <= '1';
    
    wait for 100*clock_period;
    
    
    in_raz <= '1';
    wait for clock_period;
    in_raz <= '0';
    
    
    wait for 100*clock_period;
    
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
  
  ceing: process
  begin
    while not stop_the_clock loop
      ce <= '1';
      wait for clock_period;
      ce <= '0';
      wait for 5*clock_period;
    end loop;
    wait;
  end process;

end;
  