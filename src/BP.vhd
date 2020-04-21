---------------------------------------------------------
-- VHDL top level for 8 bits processor's FSM				  
-- by Martin AUCHER & Kevin PEREZ, 02/2020
--
-- Code used for 8 bits processor courses at ENSEIRB-MATMECA
---------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY BP IS
    PORT (
        
        clk : in std_logic;
        rst : in std_logic;

        b_input  : in  std_logic;
        b_output : out std_logic

    );

END BP;

architecture Behavioral of BP is

SIGNAL MEM : STD_LOGIC;

begin
  
    PROCESS (clk)   
    BEGIN     
        IF (clk'EVENT AND clk = '1') THEN
            MEM    <= b_input;
            b_output <= (MEM XOR b_input) AND b_input;
        END IF;
    END PROCESS;

end Behavioral;