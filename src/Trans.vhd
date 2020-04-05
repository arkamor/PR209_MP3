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
            
            val_cpt_1_599_0 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            val_cpt_1_599_1 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            val_cpt_1_599_2 : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
            
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

signal BCD_Digit_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);

begin

    SEG_5 <= "1000000";
    SEG_6 <= "1000000";

    Tr0: Transcodeur_1 
    port map(
            DCB_in => val_cpt_1_599_0,
            SEG => SEG_0
        );
    Tr1: Transcodeur_1 
    port map(
            DCB_in => val_cpt_1_599_1,
            SEG => SEG_1
        );
    Tr2: Transcodeur_1 
    port map(
            DCB_in => val_cpt_1_599_2,
            SEG => SEG_2
        );
    

    -- some stuff
    
end Behavioral;

