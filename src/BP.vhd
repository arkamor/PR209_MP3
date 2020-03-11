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

        b_input  : in  std_logic;
        b_output : out std_logic

    );

END BP;

architecture Behavioral of BP is

begin
  
    PROCESS(clk) IS
    BEGIN  -- PROCESS
        IF clk'event AND clk = '1' THEN  -- rising clock edge
            IF b_input = '1' THEN -- asynchronous reset
                b_output <= '1';
            ELSE
                b_output <= '0';
            END IF;
        END IF;
    END PROCESS;

end Behavioral;