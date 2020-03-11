---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Transcodeur_1 is
    Port ( DCB_in : in STD_LOGIC_VECTOR (3 downto 0);
           SEG    : out STD_LOGIC_VECTOR (6 downto 0));
end Transcodeur_1;

architecture Behavioral of Transcodeur_1 is

signal A : STD_LOGIC;
signal B : STD_LOGIC;
signal C : STD_LOGIC;
signal D : STD_LOGIC;

begin
    A <= DCB_in(3);
    B <= DCB_in(2);
    C <= DCB_in(1);
    D <= DCB_in(0);
    
    SEG(0) <= NOT(A OR C OR (B AND D) OR (NOT B AND NOT D));
    SEG(1) <= NOT(NOT B OR (NOT C AND NOT D) OR (C AND D));
    SEG(2) <= NOT(B OR NOT C OR D);
    SEG(3) <= NOT((NOT B AND NOT D) OR (C AND NOT D) OR (B AND NOT C AND D) OR (NOT B AND C) OR A);
    SEG(4) <= NOT((NOT B AND NOT D) OR (C AND NOT D));
    SEG(5) <= NOT(A OR (NOT C AND NOT D) OR (B AND NOT C) OR (B AND NOT D));
    SEG(6) <= NOT(A OR (B AND NOT C) OR (NOT B AND C) OR (C AND NOT D));
    
end Behavioral;