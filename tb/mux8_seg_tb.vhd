
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux8_seg_tb is
end;

architecture bench of mux8_seg_tb is

  component mux8_seg
  PORT (
      sel : in STD_LOGIC_VECTOR(2 DOWNTO 0);
      SEG0 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG1 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG2 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG3 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG4 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG5 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG6 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEG7 : in  STD_LOGIC_VECTOR(6 DOWNTO 0);
      SEGDP : out STD_LOGIC;
      SEG  : out STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
  end component;

  signal sel: STD_LOGIC_VECTOR(2 DOWNTO 0);
  signal SEG0: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG1: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG2: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG3: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG4: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG5: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG6: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG7: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEGDP: STD_LOGIC;
  signal SEG: STD_LOGIC_VECTOR(6 DOWNTO 0) ;

begin

  uut: mux8_seg port map ( sel   => sel,
                           SEG0  => SEG0,
                           SEG1  => SEG1,
                           SEG2  => SEG2,
                           SEG3  => SEG3,
                           SEG4  => SEG4,
                           SEG5  => SEG5,
                           SEG6  => SEG6,
                           SEG7  => SEG7,
                           SEGDP => SEGDP,
                           SEG   => SEG );

  stimulus: process
  begin
  
    -- Put initialisation code here
    SEG0 <= "1010101";
    SEG1 <= "0000011";
    SEG2 <= "0000110";
    SEG3 <= "0001100";
    SEG4 <= "0011000";
    SEG5 <= "0110000";
    SEG6 <= "1100000";
    SEG7 <= "1111111";
    
    sel <= "000";
    wait for 10ns;
    
    sel <= "001";
    wait for 10ns;
    
    sel <= "010";
    wait for 10ns;
    
    sel <= "011";
    wait for 10ns;
    
    sel <= "100";
    wait for 10ns;
    
    sel <= "101";
    wait for 10ns;
    
    sel <= "110";
    wait for 10ns;
    
    sel <= "111";
    wait for 10ns;

    -- Put test bench stimulus code here

    wait;
  end process;


end;
  