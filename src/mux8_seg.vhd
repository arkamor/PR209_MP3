---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY mux8_seg IS
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

END mux8_seg;

architecture Behavioral of mux8_seg is

begin
  
PROCESS(sel) IS
BEGIN  -- PROCESS
    case sel is
        when "000" => 
            SEG <= SEG0;
            SEGDP <= '1';
        when "001" => 
            SEG <= SEG1;
            SEGDP <= '1';
        when "010" => 
            SEG <= SEG2;
            SEGDP <= '1';
        when "011" => 
            SEG <= SEG3;
            SEGDP <= '1';
        when "100" => 
            SEG <= SEG4;
            SEGDP <= '1';
        when "101" => 
            SEG <= SEG5;
            SEGDP <= '1';
        when "110" => 
            SEG <= SEG6;
            SEGDP <= '1';
        when "111" => 
            SEG <= SEG7;
            SEGDP <= '0';
        when others => SEG <= "0000000";
    end case;
END PROCESS;



end Behavioral;