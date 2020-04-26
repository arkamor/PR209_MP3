
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity wav_rom_tb is
end;

architecture bench of wav_rom_tb is

  component wav_rom
  PORT (
    CLOCK          : IN  STD_LOGIC;
    ADDR_R         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
    DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
    );
  end component;

  signal i_CLOCK    : STD_LOGIC;
  signal i_ADDR_R   : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal i_DATA_OUT : STD_LOGIC_VECTOR(10 DOWNTO 0);
  signal i_test     : STD_LOGIC_VECTOR(11 DOWNTO 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: wav_rom port map ( CLOCK    => i_CLOCK,
                          ADDR_R   => i_ADDR_R,
                          DATA_OUT => i_DATA_OUT
                         );

  stimulus: process
  begin
     
    -- Put test bench stimulus code here
    
    
    for i in 0 to 44099 loop
      wait for clock_period;
      i_ADDR_R <= std_logic_vector(to_unsigned(i,16));
      i_test <= std_logic_vector(to_unsigned((to_integer(signed(i_DATA_OUT))+1024)*2,12));
    end loop;
    

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      i_CLOCK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;