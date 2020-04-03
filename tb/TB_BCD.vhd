library ieee; 
use ieee.Std_logic_1164.all;
use ieee.Numeric_Std.all;

entity bcd_tb is
end;

architecture bench of bcd_tb is

  component bcd
    port (
      in_binary :  in std_logic_vector(9 downto 0);
      digit_0   : out std_logic_vector(3 downto 0);
      digit_1   : out std_logic_vector(3 downto 0);
      digit_2   : out std_logic_vector(3 downto 0);
      digit_3   : out std_logic_vector(3 downto 0)
    );
  end component;

  signal in_binary: std_logic_vector(9 downto 0);
  signal digit_0: std_logic_vector(3 downto 0);
  signal digit_1: std_logic_vector(3 downto 0);
  signal digit_2: std_logic_vector(3 downto 0);
  signal digit_3: std_logic_vector(3 downto 0) ;

begin

  uut: bcd port map ( in_binary => in_binary,
                      digit_0   => digit_0,
                      digit_1   => digit_1,
                      digit_2   => digit_2,
                      digit_3   => digit_3 );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;