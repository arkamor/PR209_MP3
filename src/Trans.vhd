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
            7_SEG_0       : out STD_LOGIC_VECTOR(6 DOWNTO 0); -- Full Droite
            7_SEG_1       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            7_SEG_2       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            7_SEG_3       : out STD_LOGIC_VECTOR(6 DOWNTO 0);

            -- Etats de la machine
            7_SEG_4       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            7_SEG_5       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            7_SEG_6       : out STD_LOGIC_VECTOR(6 DOWNTO 0);
            7_SEG_7       : out STD_LOGIC_VECTOR(6 DOWNTO 0)   -- Full Gauche

           );
end Trans;

architecture Behavioral of Trans is

component Transcodeur_1
Port (  DCB_in : in STD_LOGIC_VECTOR (3 downto 0);
        SEG    : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal BCD_Digit_0 : STD_LOGIC_VECTOR(5 DOWNTO 0);

begin

    7_SEG_5 <= '1000000';
    7_SEG_6 <= '1000000';

    Tr0: Transcodeur_1 
    port map(
            DCB_in => Clock,
            SEG => 7_SEG_0
        );
    Tr1: Transcodeur_1 
    port map(
            DCB_in => Clock,
            SEG => 7_SEG_1
        );
    Tr2: Transcodeur_1 
    port map(
            DCB_in => Clock,
            SEG => 7_SEG_2
        );
    Tr3: Transcodeur_1 
    port map(
            DCB_in => Clock,
            SEG => 7_SEG_3
        );
    

    -- some stuff
    
end Behavioral;

