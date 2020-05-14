---------------------------------------------------------
-- VHDL Transcoder for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Trans is
    Port (  restart       : in  STD_LOGIC;
            forward       : in  STD_LOGIC;
            play_pause    : in  STD_LOGIC;
            
            val_cpt_1_599 : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
            val_cpt_1_9   : in  STD_LOGIC_VECTOR(3 DOWNTO 0);

            -- Valeurs des compteurs
            SEG_0       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- ] -- Full Gauche
            SEG_1       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- -
            SEG_2       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- -
            SEG_3       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- [

            -- Etats de la machine
            SEG_4       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- 9
            SEG_5       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- 9
            SEG_6       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- 5
            SEG_7       : out STD_LOGIC_VECTOR(6 DOWNTO 0)  -- Volume -- Full Droite

           );
end Trans;

architecture Behavioral of Trans is

component Transcodeur_1
Port (  DCB_in : in STD_LOGIC_VECTOR (3 downto 0);
        SEG    : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal BCD_Digit_0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal BCD_Digit_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal BCD_Digit_2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

signal BCD_Digit_0_i : integer := 0;
signal BCD_Digit_1_i : integer := 0;
signal BCD_Digit_2_i : integer := 0;


begin
    
    Tr0: Transcodeur_1 
    port map(
        DCB_in => val_cpt_1_9,
        SEG => SEG_7
    );
    
    Tr1: Transcodeur_1 
    port map(
        DCB_in => BCD_Digit_2, -- 5
        SEG => SEG_4
    );
    
    Tr2: Transcodeur_1 
    port map(
        DCB_in => BCD_Digit_1, -- 7
        SEG => SEG_5
    );
    
    Tr3: Transcodeur_1 
    port map(
        DCB_in => BCD_Digit_0, -- 9
        SEG => SEG_6
    );
    

    -- Middle hyphen for display 
    SEG_2 <= "0111111"; -- Droite
    SEG_1 <= "0111111"; -- Gauche

           
    BCD_Digit_0_i <= (to_integer(unsigned(val_cpt_1_599))/100);
    BCD_Digit_1_i <= ((to_integer(unsigned(val_cpt_1_599)) mod 100)/10);      
    BCD_Digit_2_i <= (to_integer(unsigned(val_cpt_1_599) mod 100)mod 10);
    
    BCD_Digit_0 <=  std_logic_vector(to_unsigned(BCD_Digit_0_i,10)(3 DOWNTO 0));
    BCD_Digit_1 <=  std_logic_vector(to_unsigned(BCD_Digit_1_i,10)(3 DOWNTO 0));
    BCD_Digit_2 <=  std_logic_vector(to_unsigned(BCD_Digit_2_i,10)(3 DOWNTO 0));

    
   trans: process(restart,forward,play_pause)
   begin
        IF (restart = '0' and forward = '0') THEN -- [--- or ----
            SEG_0 <= "0111111";
        ELSE -- [--] or ---]
            SEG_0 <= "1110000";
        END IF;
        
        IF (forward = '0' and (restart = '1' or play_pause = '1')) THEN
            SEG_3 <= "1000110";
        ELSE
            SEG_3 <= "0111111";
        END IF;
    
    end process trans;
    
end Behavioral;

























