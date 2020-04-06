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

    -- Middle hyphen for display 
    SEG_5 <= "1000000"; -- Droite
    SEG_6 <= "1000000"; -- Gauche

    bcd:process(val_cpt_1_599)
    
        variable s_digit_0 : unsigned(3 downto 0);
        variable s_digit_1 : unsigned(3 downto 0);
        variable s_digit_2 : unsigned(3 downto 0);
        
        begin
        
        s_digit_0 := "0000";
        s_digit_1 := "0000";
        s_digit_2 := "0000";
        
        for i in 9 downto 0 loop
        
            if (s_digit_2 >= 5) then s_digit_2 := s_digit_2 + 3; end if;
            if (s_digit_1 >= 5) then s_digit_1 := s_digit_1 + 3; end if;
            if (s_digit_0 >= 5) then s_digit_0 := s_digit_0 + 3; end if;
            
            s_digit_2 := s_digit_2 sll 1; s_digit_2(0) := s_digit_1(3);
            s_digit_1 := s_digit_1 sll 1; s_digit_1(0) := s_digit_0(3);
            s_digit_0 := s_digit_0 sll 1; s_digit_0(0) := val_cpt_1_599(i);
        
        end loop;
        
        BCD_Digit_0 <=  std_logic_vector(s_digit_0);
        BCD_Digit_1 <=  std_logic_vector(s_digit_1);
        BCD_Digit_2 <=  std_logic_vector(s_digit_2);
        
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

























