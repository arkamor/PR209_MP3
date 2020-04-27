
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Volume_Manager_tb is
end;

architecture bench of Volume_Manager_tb is

  component Volume_Manager
      Port (
          clk     : IN STD_LOGIC;
          rst     : IN STD_LOGIC;
          ce      : IN STD_LOGIC;
          volume  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          idata   : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
          odata   : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
          );
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal ce: STD_LOGIC;
  signal volume: STD_LOGIC_VECTOR(3 DOWNTO 0);
  signal idata: STD_LOGIC_VECTOR(10 DOWNTO 0);
  signal odata: STD_LOGIC_VECTOR(10 DOWNTO 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Volume_Manager port map ( clk    => clk,
                                 rst    => rst,
                                 ce     => ce,
                                 volume => volume,
                                 idata  => idata,
                                 odata  => odata );

  stimulus: process
  begin
  
    -- Put initialisation code here
    idata <= "11111111111";
    rst <= '0';
    ce <= '1';
    
    wait for 5*clock_period;
    
    rst <= '1';
    
    -- Put test bench stimulus code here
    
    volume <= std_logic_vector(to_unsigned(9,4));
    wait for 5*clock_period;
    
    volume <= std_logic_vector(to_unsigned(1,4));
    wait for 5*clock_period;
    
    volume <= std_logic_vector(to_unsigned(5,4));
    wait for 5*clock_period;
    
    volume <= std_logic_vector(to_unsigned(3,4));
    wait for 5*clock_period;
    
    volume <= std_logic_vector(to_unsigned(7,4));
    wait for 5*clock_period;
    

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