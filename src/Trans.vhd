---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
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
            SEG_0       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- Full Droite
            SEG_1       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            SEG_2       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            SEG_3       : out STD_LOGIC_VECTOR(6 DOWNTO 0);

            -- Etats de la machine
            SEG_4       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            SEG_5       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            SEG_6       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            SEG_7       : out STD_LOGIC_VECTOR(6 DOWNTO 0)   -- Full Gauche

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

signal BCD_Digit_0_i : UNSIGNED(9 DOWNTO 0);
signal BCD_Digit_1_i : UNSIGNED(9 DOWNTO 0);
signal BCD_Digit_2_i : UNSIGNED(9 DOWNTO 0);


begin
    
    Tr0: Transcodeur_1 
    port map(
        DCB_in => BCD_Digit_0,
        SEG => SEG_0
    );
    
    Tr1: Transcodeur_1 
    port map(
        DCB_in => BCD_Digit_1,
        SEG => SEG_1
    );
    
    Tr2: Transcodeur_1 
    port map(
        DCB_in => BCD_Digit_2,
        SEG => SEG_2
    );
    
    Tr3: Transcodeur_1 
    port map(
        DCB_in => val_cpt_1_9,
        SEG => SEG_3
    );
    

    -- Middle hyphen for display 
    SEG_5 <= "1000000"; -- Droite
    SEG_6 <= "1000000"; -- Gauche

    bcd:process(val_cpt_1_599)
    begin
        
        BCD_Digit_0_i <= (Unsigned(val_cpt_1_599)/100);
        BCD_Digit_1_i <= (Unsigned(val_cpt_1_599) mod 100)/10;      
        BCD_Digit_2_i  <= (Unsigned(val_cpt_1_599) mod 100)mod 10;
        
        BCD_Digit_0 <=  std_logic_vector(BCD_Digit_0_i(3 DOWNTO 0));
        BCD_Digit_1 <=  std_logic_vector(BCD_Digit_1_i(3 DOWNTO 0));
        BCD_Digit_2 <=  std_logic_vector(BCD_Digit_2_i(3 DOWNTO 0));
        
    end process bcd;
    
   trans: process(restart,forward,play_pause)
   begin
        IF (restart = '0' and forward = '0') THEN -- [--- or ----
            SEG_4 <= "1000000";
        ELSE -- [--] or ---]
            SEG_4 <= "0001111";
        END IF;
        
        IF (forward = '0' and (restart = '1' or play_pause = '1')) THEN
            SEG_7 <= "0111001";
        ELSE
            SEG_7 <= "1000000";
        END IF;
    
    end process trans;
    
end Behavioral;

























