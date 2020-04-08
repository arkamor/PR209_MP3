
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Trans_tb is
end;

architecture bench of Trans_tb is

  component Trans
      Port (  restart       : in  STD_LOGIC;
              forward       : in  STD_LOGIC;
              play_pause    : in  STD_LOGIC;
              val_cpt_1_599 : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
              val_cpt_1_9   : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
              SEG_0       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_1       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_2       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_3       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_4       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_5       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_6       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
              SEG_7       : out STD_LOGIC_VECTOR(6 DOWNTO 0)
             );
  end component;

  signal restart: STD_LOGIC;
  signal forward: STD_LOGIC;
  signal play_pause: STD_LOGIC;
  signal val_cpt_1_599: STD_LOGIC_VECTOR(9 DOWNTO 0);
  signal val_cpt_1_9: STD_LOGIC_VECTOR(3 DOWNTO 0);
  signal SEG_0: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_1: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_2: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_3: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_4: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_5: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_6: STD_LOGIC_VECTOR(6 DOWNTO 0);
  signal SEG_7: STD_LOGIC_VECTOR(6 DOWNTO 0);

begin

  uut: Trans port map ( restart       => restart,
                        forward       => forward,
                        play_pause    => play_pause,
                        val_cpt_1_599 => val_cpt_1_599,
                        val_cpt_1_9   => val_cpt_1_9,
                        SEG_0         => SEG_0,
                        SEG_1         => SEG_1,
                        SEG_2         => SEG_2,
                        SEG_3         => SEG_3,
                        SEG_4         => SEG_4,
                        SEG_5         => SEG_5,
                        SEG_6         => SEG_6,
                        SEG_7         => SEG_7 );

  stimulus: process
  begin
  
    -- Put initialisation code here
    
    restart <= '0';
    forward <= '0';
    play_pause <= '0';
    
    val_cpt_1_599 <= "0011001000";
    val_cpt_1_9 <= "1001";
    
    wait for 333ns;
    
    val_cpt_1_599 <= "0001101110";
    val_cpt_1_9 <= "0101";
    
    wait for 333ns;
    
    val_cpt_1_599 <= "1000001101";
    val_cpt_1_9 <= "0111";
    
    wait for 333ns;
    
    
    
    
    

    -- Put test bench stimulus code here

    wait;
  end process;


end;