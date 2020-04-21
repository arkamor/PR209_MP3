
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PWM_tb is
end;

architecture bench of PWM_tb is

  component PWM
  Port (
      clk     : in STD_LOGIC;
      ce_441  : in STD_LOGIC;
      rst     : in STD_LOGIC;
    
      i_data : in STD_LOGIC_VECTOR(10 DOWNTO 0);
        
      o_data : out STD_LOGIC;
      
      o_data_en : out STD_LOGIC
  );
  end component;

  signal clk    : STD_LOGIC;
  signal ce_441 : STD_LOGIC;
  signal rst    : STD_LOGIC;
  
  signal i_data : STD_LOGIC_VECTOR(10 DOWNTO 0);
  
  signal o_data : STD_LOGIC;
  
  signal o_data_en : STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: PWM port map ( clk    => clk,
                      ce_441    => ce_441,
                      rst    => rst,
                      i_data    => i_data,
                      o_data    => o_data,
                      o_data_en => o_data_en
                     );

  stimulus: process
  begin
     
    -- Put test bench stimulus code here
    rst <= '0';
    wait for clock_period;
    rst <= '1';
    
    
    
    i_data <= std_logic_vector(to_signed(695,11));
    
    ce_441 <= '1';
    wait for clock_period;
    ce_441 <= '0';
    
    wait for 2266*clock_period;
    
    i_data <= std_logic_vector(to_signed(-420,11));
    
    ce_441 <= '1';
    wait for clock_period;
    ce_441 <= '0';
    
    wait for 2266*clock_period;
    

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