---------------------------------------------------------
-- VHDL Debouncer for audio Project			  
-- by Martin AUCHER & Kevin PEREZ, 04/2020
--
-- Code used foraudio Project courses at ENSEIRB-MATMECA
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

SIGNAL output : STD_LOGIC;
SIGNAL count : unsigned(26 downto 0) := (others => '0');

begin
  
    PROCESS(clk,rst) IS
    BEGIN  -- PROCESS
        IF rst='0' THEN
            count <= (others => '0');
        ELSIF clk'event AND clk = '0' THEN  -- rising clock edge
            IF count=0 THEN
                IF b_input = '1' THEN -- asynchronous reset
                    output <= '1';
                    count <= to_unsigned(1,27);
                ELSE
                    output <= '0';
                END IF;
            ELSE
                output <= '0';
                count <= count + 1;
                IF count=50000000 THEN
                    count <= to_unsigned(0,27);
                END IF;
            END IF;
        END IF;
    END PROCESS;

b_output <= output;

end Behavioral;